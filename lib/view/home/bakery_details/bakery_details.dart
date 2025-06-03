import 'package:completefoodorderingappui/models/bakery_model.dart';
import 'package:completefoodorderingappui/view/add_to_cart/add_to_cart.dart';
import 'package:completefoodorderingappui/view/home/bakery_details/widgets/deals_widget.dart';
import 'package:completefoodorderingappui/view/home/cart/cart_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RestaurantMenuScreen extends StatefulWidget {
  final BakeryModel model;
  const RestaurantMenuScreen({super.key, required this.model});

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<List<Map<String, dynamic>>> getMenuItems() {
    if (widget.model.items.isEmpty) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('items')
        .where(FieldPath.documentId, whereIn: widget.model.items)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .where((doc) => doc.data()['visibility'] == true)
          .map((doc) {
        final data = doc.data();
        dynamic itemPrice = data['itemPrice'];
        dynamic quantity = data['quantity'];

        return {
          'uid': doc.id,
          'itemName': data['itemName'] ?? 'Unknown Item',
          'itemDescription':
              data['itemDescription'] ?? 'No description available',
          'itemPrice': itemPrice,
          'imageUrl': data['imageUrl'] ?? '',
          'quantity': quantity,
          'adminId': data['adminId']
        };
      }).toList();
    });
  }

  Stream<bool> checkUserCartItems() {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return Stream.value(false);
    }

    return FirebaseFirestore.instance
        .collection('cart')
        .where('customerId', isEqualTo: currentUser.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: StreamBuilder<bool>(
        stream: checkUserCartItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
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
              child: GestureDetector(
                onTap: () {
                  Get.to(const CartScreen(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff20402A),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        "View Cart",
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
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
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
                  child: widget.model.listofimages.isNotEmpty
                      ? Image.network(
                          widget.model.listofimages[0],
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
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(50)),
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
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 15,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 24.67.h,
                          width: 54.83.w,
                          decoration: const BoxDecoration(
                            color: Color(0xffFFC107),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Image(
                                  image: AssetImage("images/Star 1.png")),
                              SizedBox(width: 5.w),
                              Text(
                                "${widget.model.bakeryReview}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.21.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
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
                    widget.model.bakeryName,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff20402A),
                    ),
                  ),
                  Text(
                    widget.model.bakeryDescription,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16.sp, color: Colors.black),
                      SizedBox(width: 5.w),
                      Text(
                        'Pickup Time: ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        widget.model.bakeryTiming,
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
                      Icon(Icons.location_on, size: 16.sp, color: Colors.black),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: Text(
                          widget.model.bakeryLocation,
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
                  SizedBox(height: 10.h),
                  dealsWidget()
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: getMenuItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircularProgressIndicator(
                        color: Color(0xff20402A),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Error loading items: ${snapshot.error}'),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "No menu items found for this bakery.",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: snapshot.data!
                        .map((item) => _buildItemWidget(item))
                        .toList(),
                  );
                }
              },
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }

  Widget _buildItemWidget(Map<String, dynamic> item) {
    final int qty = (item['quantity'] ?? 0) as int;
    String badgeText;
    if (qty == 0) {
      badgeText = 'Sold Out';
    } else if (qty < 5) {
      badgeText = 'Only $qty left';
    } else {
      badgeText = '$qty available';
    }
    final bool isSoldOut = qty == 0;
    return AbsorbPointer(
      absorbing: isSoldOut,  
      child: Opacity(
        opacity: isSoldOut ? 0.5 : 1.0,
        child: GestureDetector(
          onTap: () {
            Get.to(
              () => AddToCart(
                  itemId: item['uid'],
                  itemName: item['itemName'],
                  itemDescription: item['itemDescription'],
                  bakeryName: widget.model.bakeryName,
                  pickupTime: widget.model.bakeryTiming,
                  itemPrice: item['itemPrice'],
                  quantity: item['quantity'],
                  imageUrl: item['imageUrl'] ?? '',
                  adminId: item['adminId'] ?? ''),
              transition: Transition.rightToLeft,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: IntrinsicHeight(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    // color: Colors.grey.withOpacity(0.3),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              item['itemName'],
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff20402A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['itemDescription'],
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff454745),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  "Rs. ${item['itemPrice']}",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff20402A),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8.0, bottom: 8, right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            height: 100,
                            child: Stack(
                              children: [
                                // 1️⃣ The background image
                                Positioned.fill(
                                  child: item['imageUrl'] != null &&
                                          item['imageUrl'].toString().isNotEmpty
                                      ? Image.network(
                                          item['imageUrl'],
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'images/item.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                Positioned(
                                  top: 5,
                                  left: -2,
                                  height: 25,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadiusGeometry.only(
                                      topRight: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.grey, width: 0.6),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(8),
                                            bottomRight: Radius.circular(8),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset('images/bag.svg'),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              badgeText,
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xff20402A),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
