import 'package:completefoodorderingappui/view/add_to_cart/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddToCart extends StatefulWidget {
  final String itemId;
  final String itemName;
  final String itemDescription;
  final String bakeryName;
  final String pickupTime;
  final dynamic itemPrice;
  final dynamic quantity;
  final String imageUrl;
  final String adminId;

  const AddToCart({
    super.key,
    required this.itemId,
    required this.itemName,
    required this.itemDescription,
    required this.bakeryName,
    required this.pickupTime,
    required this.itemPrice,
    required this.quantity,
    required this.imageUrl,
    required this.adminId
  });

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  late int _selectedQuantity;
  late int _totalPrice;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedQuantity = 1;
    _totalPrice = _parsePrice(widget.itemPrice);
  }

  int _parsePrice(dynamic price) {
    if (price is int) {
      return price;
    } else if (price is String) {
      return int.tryParse(price) ?? 0;
    } else {
      return 0;
    }
  }

  int _parseQuantity(dynamic quantity) {
    if (quantity is int) {
      return quantity;
    } else if (quantity is String) {
      return int.tryParse(quantity) ?? 0;
    } else {
      return 0;
    }
  }

  void _incrementQuantity() {
    int maxQuantity = _parseQuantity(widget.quantity);
    if (_selectedQuantity < maxQuantity) {
      setState(() {
        _selectedQuantity++;
        _totalPrice = _parsePrice(widget.itemPrice) * _selectedQuantity;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Maximum available quantity is $maxQuantity'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _decrementQuantity() {
    if (_selectedQuantity > 1) {
      setState(() {
        _selectedQuantity--;
        _totalPrice = _parsePrice(widget.itemPrice) * _selectedQuantity;
      });
    }
  }

  Future<void> _addToCart() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please sign in to add items to cart'),
        duration: Duration(seconds: 2),
      ),
    );
    return;
  }

  setState(() {
    _isLoading = true;
  });

  try {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartCollection = FirebaseFirestore.instance.collection('cart');
    final docRef = cartCollection.doc();

    // Step 1: Check and update item stock using transaction
    final itemDocRef = FirebaseFirestore.instance.collection('items').doc(widget.itemId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final itemSnapshot = await transaction.get(itemDocRef);

      if (!itemSnapshot.exists) {
        throw Exception("Item not found.");
      }

      final currentQuantity = itemSnapshot.get('quantity');
      if (_selectedQuantity > currentQuantity) {
        throw Exception("Not enough stock available.");
      }

      final newQuantity = currentQuantity - _selectedQuantity;
      transaction.update(itemDocRef, {'quantity': newQuantity});
    });

    // Step 2: Add to cart
    final cartItem = {
      'uid': docRef.id,
      'customerId': currentUser.uid,
      'itemId': widget.itemId,
      'itemName': widget.itemName,
      'itemPrice': _parsePrice(widget.itemPrice),
      'quantity': _selectedQuantity,
      'bakeryName': widget.bakeryName,
      'imageUrl': widget.imageUrl,
      'totalPrice': _totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
      'adminId': widget.adminId
    };

    await docRef.set(cartItem);

    // Step 3: Notify cart provider
    cartProvider.addToCart(
      itemId: widget.itemId,
      itemName: widget.itemName,
      itemPrice: _parsePrice(widget.itemPrice),
      quantity: _selectedQuantity,
      bakeryName: widget.bakeryName,
      imageUrl: widget.imageUrl,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added to cart successfully!'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to add item to cart: ${e.toString()}'),
        duration: const Duration(seconds: 3),
      ),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    String badgeText;
    if (widget.quantity == 0) {
      badgeText = 'Sold Out';
    } else if (widget.quantity < 5) {
      badgeText = 'Only ${widget.quantity} left';
    } else {
      badgeText = '${widget.quantity} available';
    }
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 250,
                  child: widget.imageUrl.isNotEmpty
                      ? Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'images/item.png',
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          'images/item.png',
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 45.h,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Text(
                                    "Back",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                          child: Container(
                            height: 30.h,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: [Text(badgeText)],
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
            SizedBox(height: 17.h),
            Container(
              width: 335.w,
              decoration: BoxDecoration(
                color: const Color(0xffEEEEE6),
                borderRadius: BorderRadius.circular(17.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.itemName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff20402A),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    widget.itemDescription,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.store, size: 16.sp, color: Colors.black),
                      SizedBox(width: 5.w),
                      Text(
                        widget.bakeryName,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16.sp, color: Colors.black),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          'Pickup Time: ${widget.pickupTime}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _decrementQuantity,
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xff20402A), width: 3),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.remove,
                        color: Color(0xff20402A),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  width: 70.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      "$_selectedQuantity",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: _incrementQuantity,
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(0xff20402A), width: 3),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Color(0xff20402A),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Quantity Selected:",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "$_selectedQuantity",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Text(
                    "Total Price:",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Rs. $_totalPrice",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff20402A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: _isLoading ? null : _addToCart,
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _isLoading ? Colors.grey : const Color(0xff20402A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Add To Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
