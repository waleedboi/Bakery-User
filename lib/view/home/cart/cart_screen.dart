import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/services/stripe_service.dart';
import 'package:completefoodorderingappui/view/bottombar/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
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
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
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
        return;
      }

      // Group items by adminId
      Map<String, List<Map<String, dynamic>>> itemsByAdmin = {};
      for (var item in itemsData) {
        String adminId = item['adminId'];
        if (!itemsByAdmin.containsKey(adminId)) {
          itemsByAdmin[adminId] = [];
        }
        itemsByAdmin[adminId]!.add(item);
      }

      // Process payment for each admin's items
      for (var entry in itemsByAdmin.entries) {
        String adminId = entry.key;
        List<Map<String, dynamic>> adminItems = entry.value;
        
        // Calculate total for this admin's items
        double adminTotal = adminItems.fold(0, (sum, item) => sum + (item['totalPrice'] as num));

        // Create payment intent for this admin
        final paymentIntentResult = await StripeService.createPaymentIntent(
          amount: (adminTotal * 100).round().toString(),
          currency: currency,
          customerId: user.uid,
          orderId: orderId,
          adminId: adminId,
        );

        if (paymentIntentResult == null) {
          throw 'Failed to create payment intent for ${adminItems.first['bakeryName']}';
        }

        // Initialize payment sheet
        await StripeService.initializePaymentSheet(
          paymentIntentClientSecret: paymentIntentResult['client_secret'],
          adminId: adminId,
        );

        // Present payment sheet
        await Stripe.instance.presentPaymentSheet();

        // Create order for this admin
        await createOrder(
          orderId: '${orderId}_$adminId',
          customerId: user.uid,
          items: adminItems,
          totalAmount: adminTotal,
          paymentStatus: 'completed',
          paymentIntentId: paymentIntentResult['id'],
          adminId: adminId,
        );
      }

      await clearCart();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful! Orders placed.'),
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

  Future<void> createOrder({
    required String orderId,
    required String customerId,
    required List<Map<String, dynamic>> items,
    required double totalAmount,
    required String paymentStatus,
    required String paymentIntentId,
    required String adminId,
  }) async {
    try {
      final orderData = {
        'orderId': orderId,
        'customerId': customerId,
        'items': items,
        'totalAmount': totalAmount,
        'paymentStatus': paymentStatus,
        'paymentIntentId': paymentIntentId,
        'bakeryName': items.first['bakeryName'],
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

      final adminRef =
          FirebaseFirestore.instance.collection('admins').doc(adminId);

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final adminSnapshot = await transaction.get(adminRef);
        if (!adminSnapshot.exists) return;

        final data = adminSnapshot.data() ?? {};

        final currentOrders = (data['totalOrders'] ?? 0) as int;
        final currentRevenue = (data['revenue'] ?? 0.0) as num;

        transaction.update(adminRef, {
          'totalOrders': currentOrders + 1,
          'revenue': currentRevenue + totalAmount,
        });
      });
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
        'bakeryName': doc['bakeryName'] ?? 'Unknown Bakery',
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
      body: isDeleting
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : StreamBuilder<QuerySnapshot>(
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
                                                    color:
                                                        const Color(0xff20402A),
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
                                                    color:
                                                        const Color(0xff454745),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: GestureDetector(
                                              onTap: () async {
                                                final quantityToAdd =
                                                    doc['quantity'];
                                                final itemId = doc['itemId'];

                                                try {
                                                  setState(() {
                                                    isDeleting = true;
                                                  });
                                                  final itemDocRef =
                                                      FirebaseFirestore.instance
                                                          .collection('items')
                                                          .doc(itemId);

                                                  // Run transaction to safely update item quantity
                                                  await FirebaseFirestore
                                                      .instance
                                                      .runTransaction(
                                                          (transaction) async {
                                                    final snapshot =
                                                        await transaction
                                                            .get(itemDocRef);

                                                    if (!snapshot.exists)
                                                      return;

                                                    final currentStock =
                                                        snapshot['quantity'] ??
                                                            0;

                                                    transaction
                                                        .update(itemDocRef, {
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
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Error removing item: ${e.toString()}'),
                                                      duration: const Duration(
                                                          seconds: 3),
                                                    ),
                                                  );
                                                } finally {
                                                  setState(() {
                                                    isDeleting = false;
                                                  });
                                                }
                                              },
                                              child: Container(
                                                height: 30.h,
                                                width: 30.h,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red
                                                      .withOpacity(0.3),
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 25,
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
