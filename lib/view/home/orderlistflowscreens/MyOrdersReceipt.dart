
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/view/widget/clipper.dart';
import 'package:completefoodorderingappui/view/home/orderlistflowscreens/orderReceiptreview.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyOrdersReceiptScreen extends StatefulWidget {
  const MyOrdersReceiptScreen({super.key});

  @override
  State<MyOrdersReceiptScreen> createState() => _MyOrdersReceiptScreenState();
}

class _MyOrdersReceiptScreenState extends State<MyOrdersReceiptScreen> {
  int? rate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: 435.h,
          width: 318.w,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
        Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          color: Color(0xffEEEEE6),
          child: Column(
            children: [
              ClipPath(
                clipper: TopClipper(),
                child: Container(
                  height: 324.h,
                  width: 375.w,
                  color: AppColors.primaryColor,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 55.h,
                          ),
                          AppBarClass(
                            text: "My orders",
                            color: const Color(0xffFFFFFF),
                            iconcolor: const Color(0xffFFFFFF),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 106.h,
              ),
              Container(
                height: 435.h,
                width: 318.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      "Your Order",
                      style: TextStyle(
                        fontSize: 17.26.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Image(
                            image: const AssetImage("images/verified.png"),
                            height: 17.68.sp,
                            width: 17.68.sp,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "Order Confirmed",
                          style: TextStyle(
                              color: const Color(0xff009245),
                              fontSize: 15.48.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 88.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    CustomButtons(
                        borderRadius: 10.r,
                        child: Text(
                          "Order ID : Takkul#4567",
                          style: TextStyle(
                            color: Color(0xff20402A),
                            fontSize: 14.36.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        width: 188.w,
                        height: 32.h,
                        onPressed: () {},
                        backcolor: Color(0xffEDF0EE)),
                    SizedBox(
                      height: 33.h,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Total Amount :",
                                style: TextStyle(
                                  color: Color(0xff20402A),
                                  fontSize: 12.71.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "AED 20",
                                style: TextStyle(
                                  color: Color(0xff20402A),
                                  fontSize: 12.71.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Pickup Address :",
                                style: TextStyle(
                                  color: Color(0xff20402A),
                                  fontSize: 12.71.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Al Barsha 1, Al",
                                style: TextStyle(
                                  color: Color(0xff20402A),
                                  fontSize: 12.71.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            children: [
                              Text(
                                "Collection Time :",
                                style: TextStyle(
                                  color: Color(0xff20402A),
                                  fontSize: 12.71.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "7:00 PM - 7.30 PM",
                                style: TextStyle(
                                  color: Color(0xff20402A),
                                  fontSize: 12.71.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 48.h,
                    ),
                    Column(
                      children: [
                        Text(
                          "Note",
                          style: TextStyle(
                            color: Color(0xff20402A),
                            fontSize: 12.71.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "The store will provide packaging for your\n    food, but we encourage you to bring\n       your own bag to carry it home in.",
                          style: TextStyle(
                            color: Color(0xff1B1B1B),
                            fontSize: 12.71.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 23.h,
                        ),
                        Container(
                          height: 28.h,
                          width: 127.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Color(0xffFFC107).withOpacity(0.25)),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: Text(
                              "Need Help?",
                              style: TextStyle(
                                color: Color(0xff20402A),
                                fontSize: 12.71.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 110.h,
                width: 318.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 18.h,
                    ),
                    Text(
                      "Rate your order",
                      style: TextStyle(
                        color: Color(0xff20402A),
                        fontSize: 12.71.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "We appreciate your honest reviews!",
                      style: TextStyle(
                        color: Color(0xff20402A),
                        fontSize: 12.71.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => InkWell(
                          onTap: () {
                            rate = index;
                            setState(() {});

                            Get.to(() => OrderReceiptReview(index: rate!),transition: Transition.rightToLeft);
                          },
                          child: Icon(
                            Icons.star,
                            color: rate == null
                                ? Color(0xffD9D9D9)
                                : rate! >= index
                                    ? ButtonsColors.secondaryColor
                                    : Color(0xffD9D9D9),
                            size: 25.sp,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 86.h,
              )
            ],
          ),
        ),
      ],
    ));
  }
}
