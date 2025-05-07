import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/view/bottombar/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? bakeryName;
  String? location;
  bool _isLoading = false;

  Future<void> initStripe() async {
    Stripe.publishableKey =
        'pk_live_51RBwfcBc9GZiVt1MckyJCoOXFNcVsoSPzMMGvpIqQ8LT7vAYgvTDsPpGYrnG7Fx8tA0Ejua8filc5Azed1mQdBcP00Y6hpx0sW';
    await Stripe.instance.applySettings();
  }

  @override
  void initState() {
    super.initState();
    initStripe();
  }

  Future<void> processPayment(double amount, String currency,
      List<Map<String, dynamic>> itemsData) async {
    try {
      setState(() {
        _isLoading = true;
      });

      final orderId = const Uuid().v4();
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login to continue')),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final paymentIntentResult = await createPaymentIntent(
        amount: (amount * 100).round().toString(),
        currency: currency,
        customerId: user.uid,
        orderId: orderId,
      );

      if (paymentIntentResult == null) {
        throw 'Failed to create payment intent';
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentResult['client_secret'],
          merchantDisplayName: 'Your Bakery App',
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xff20402A),
            ),
          ),
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      await createOrder(
        orderId: orderId,
        customerId: user.uid,
        items: itemsData,
        totalAmount: amount,
        paymentStatus: 'completed',
        paymentIntentId: paymentIntentResult['id'],
      );

      await clearCart();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful! Order placed.'),
          backgroundColor: Colors.green,
          padding: EdgeInsets.all(8),
        ),
      );
      Get.offAll(const BottomBarScreen());
    } catch (e) {
      print('Payment error: $e');
      String errorMessage = 'Something went wrong with the payment';

      if (e is StripeException) {
        if (e.error.code == 'canceled') {
          errorMessage = 'Payment canceled';
        } else {
          errorMessage = e.error.message ?? 'Payment failed';
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>?> createPaymentIntent({
    required String amount,
    required String currency,
    required String customerId,
    required String orderId,
  }) async {
    try {
      const secretKey =
          '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';

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amount,
          'currency': currency,
          'metadata[customer_id]': customerId,
          'metadata[order_id]': orderId,
          'automatic_payment_methods[enabled]': 'true',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error creating payment intent: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception during payment intent creation: $e');
      return null;
    }
  }

  Future<void> createOrder({
    required String orderId,
    required String customerId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String paymentStatus,
    required String paymentIntentId,
  }) async {
    try {
      final String? adminId = items.isNotEmpty ? items.first['adminId'] : null;

      final orderData = {
        'orderId': orderId,
        'customerId': customerId,
        'items': items,
        'totalAmount': totalAmount,
        'paymentStatus': paymentStatus,
        'paymentIntentId': paymentIntentId,
        'bakeryName': bakeryName,
        'orderDate': FieldValue.serverTimestamp(),
        'status': 'pending',
        'adminId': adminId,
      };

      await FirebaseFirestore.instance
          .collection('orders')
          .doc(orderId)
          .set(orderData);

      for (final item in items) {
        final itemRef =
            FirebaseFirestore.instance.collection('items').doc(item['itemId']);

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final itemSnapshot = await transaction.get(itemRef);
          if (!itemSnapshot.exists) {
            return;
          }

          final currentStock = itemSnapshot['quantity'] ?? 0;
          final newStock = currentStock - item['quantity'];

          transaction
              .update(itemRef, {'quantity': newStock >= 0 ? newStock : 0});
        });
      }
      if (adminId != null) {
        final adminRef =
            FirebaseFirestore.instance.collection('admins').doc(adminId);

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final adminSnapshot = await transaction.get(adminRef);
          if (!adminSnapshot.exists) return;

          final currentOrders = adminSnapshot['totalOrders'] ?? 0;
          final currentRevenue = adminSnapshot['revenue'] ?? 0.0;

          transaction.update(adminRef, {
            'totalOrders': (currentOrders as int) + 1,
            'revenue': (currentRevenue as num) + totalAmount,
          });
        });
      }
    } catch (e) {
      print('Error creating order: $e');
      rethrow;
    }
  }

  Future<void> clearCart() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final cartSnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .where('customerId', isEqualTo: user.uid)
          .get();

      for (final doc in cartSnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      print('Error clearing cart: $e');
    }
  }

  List<Map<String, dynamic>> extractCartItemsData(
      List<QueryDocumentSnapshot> docs) {
    return docs.map((doc) {
      return {
        'itemId': doc['itemId'] ?? '',
        'itemName': doc['itemName'] ?? 'Unknown',
        'quantity': doc['quantity'] is String
            ? int.tryParse(doc['quantity']) ?? 0
            : doc['quantity'] ?? 0,
        'itemPrice': doc['itemPrice'] is String
            ? double.tryParse(doc['itemPrice']) ?? 0.0
            : doc['itemPrice'] ?? 0.0,
        'totalPrice': doc['totalPrice'] is String
            ? double.tryParse(doc['totalPrice']) ?? 0.0
            : doc['totalPrice'] ?? 0.0,
        'adminId': doc['adminId'] ?? 'unknown',
      };
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: const Color(0xffEEEEE6),
      ),
      bottomNavigationBar: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final docs = snapshot.data!.docs;

          int totalQuantity = 0;
          double totalPrice = 0.0;

          for (var doc in docs) {
            var quantity = doc['quantity'];
            var price = doc['totalPrice'];

            if (quantity is String) quantity = int.tryParse(quantity) ?? 0;
            if (price is String) price = double.tryParse(price) ?? 0.0;

            totalQuantity += quantity is num ? quantity.toInt() : 0;
            totalPrice += price is num ? price.toDouble() : 0.0;
          }

          final cartItems = extractCartItemsData(docs);

          return Container(
            decoration: BoxDecoration(
              color: const Color(0xffEEEEE6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Quantity Selected'),
                    Text('$totalQuantity'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Price'),
                    Text('Rs ${totalPrice.toStringAsFixed(2)}'),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _isLoading || docs.isEmpty
                      ? null
                      : () => processPayment(totalPrice, 'pkr', cartItems),
                  child: Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          docs.isEmpty ? Colors.grey : const Color(0xff20402A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Icon(Icons.shopping_cart,
                                color: Colors.white),
                        SizedBox(width: 10.w),
                        Text(
                          _isLoading ? "Processing..." : "Checkout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartDocs = snapshot.data!.docs;

          if (cartDocs.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }

          // Store bakeryName and location from first item
          if (bakeryName == null || location == null) {
            final firstDoc = cartDocs.first;
            bakeryName = firstDoc['bakeryName'] ?? 'N/A';
            // location = firstDoc['location'] ?? 'N/A';
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.store),
                    const SizedBox(width: 5),
                    Text(bakeryName ?? 'Bakery Name'),
                  ],
                ),
                // const SizedBox(height: 15),
                // Row(
                //   children: [
                //     const Icon(Icons.location_on_outlined),
                //     const SizedBox(width: 5),
                //     Text(location ?? 'Location'),
                //   ],
                // ),
                const SizedBox(height: 20),
                ...cartDocs.map((doc) {
                  final itemName = doc['itemName'] ?? 'Unknown';
                  final itemQuantity = doc['quantity'];
                  final docId = doc.id;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: IntrinsicHeight(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: SizedBox(
                                    height: 60.h,
                                    child: Image.asset(
                                      'images/item.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text(
                                            itemName,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff20402A),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Text(
                                            'quantity: x$itemQuantity',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff454745),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          final quantityToAdd = doc['quantity'];
                                          final itemId = doc['itemId'];

                                          try {
                                            final itemDocRef = FirebaseFirestore
                                                .instance
                                                .collection('items')
                                                .doc(itemId);

                                            // Run transaction to safely update item quantity
                                            await FirebaseFirestore.instance
                                                .runTransaction(
                                                    (transaction) async {
                                              final snapshot = await transaction
                                                  .get(itemDocRef);

                                              if (!snapshot.exists) return;

                                              final currentStock =
                                                  snapshot['quantity'] ?? 0;

                                              transaction.update(itemDocRef, {
                                                'quantity': currentStock +
                                                    quantityToAdd,
                                              });

                                              // Now delete the cart item
                                              transaction.delete(
                                                FirebaseFirestore.instance
                                                    .collection('cart')
                                                    .doc(docId),
                                              );
                                            });

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Item removed from cart and stock updated.'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Error removing item: ${e.toString()}'),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          height: 25.h,
                                          width: 25.h,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.red.withOpacity(0.3),
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}
