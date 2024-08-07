import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrdersTopickupScreen extends StatefulWidget {
  const MyOrdersTopickupScreen({super.key});

  @override
  State<MyOrdersTopickupScreen> createState() => _MyOrdersTopickupScreenState();
}

class _MyOrdersTopickupScreenState extends State<MyOrdersTopickupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: const Color(0xffEEEEE6),
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            AppBarClass(
              text: "My orders",
              color: const Color(0xff20402A),
              iconcolor: const Color(0xff1B4332),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButtons(
                    onPressed: () {},
                    borderRadius: 36.r,
                    width: 162.42.w,
                    height: 53.h,
                    backcolor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonText(
                          color: ButtonsColors.secondaryColor,
                          text: 'To Pick up',
                          Font: FontWeight.w700,
                          fontsize: 14.sp,
                        ),
                      ],
                    )),
                CustomButtons(
                    onPressed: () {},
                    borderRadius: 36.r,
                    width: 162.42.w,
                    height: 53.h,
                    backcolor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonText(
                          color: ButtonsColors.secondaryColor,
                          text: 'Past Orders',
                          Font: FontWeight.w400,
                          fontsize: 14.sp,
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: 26.h,
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Container(
                height: 135.h,
                width: 342.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.r),
                  color: Color(0xffF3F3ED),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 26.w,
                        ),
                        Text(
                          "Pastries Box",
                          style: TextStyle(
                              fontSize: 16.17.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 51.w,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Image(
                                image: AssetImage("images/verified.png"),
                                height: 17.68.sp,
                                width: 17.68.sp,
                              ),
                            ),
                            Text(
                              "Order Confirmed",
                              style: TextStyle(
                                  color: Color(0xff009245),
                                  fontSize: 15.48.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 50,
                      ),
                      child: Text(
                        "Eat Greek Kozina Food Bakery Restaurant",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 13.29.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18.w,
                          ),
                          Image(
                            image: AssetImage("images/clock 1.png"),
                            height: 13.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            " 09:00-16:00",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18.w,
                          ),
                          Image(
                            image: AssetImage("images/geo-alt 1.png"),
                            height: 15.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "25 m - Al Barsha 1, Al Rabwah, Shop No. 11",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
              child: Container(
                height: 135.h,
                width: 342.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.r),
                  color: Color(0xffF3F3ED),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 26.w,
                        ),
                        Text(
                          "Pastries Box",
                          style: TextStyle(
                              fontSize: 16.17.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 51.w,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Image(
                                image: AssetImage("images/pendingicon.png"),
                                height: 17.68.sp,
                                width: 17.68.sp,
                              ),
                            ),
                            Text(
                              "Order Pending",
                              style: TextStyle(
                                  color: Color(0xffE38D1E),
                                  fontSize: 15.48.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 50,
                      ),
                      child: Text(
                        "Eat Greek Kozina Food Bakery Restaurant",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 13.29.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 11.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18.w,
                          ),
                          Image(
                            image: AssetImage("images/clock 1.png"),
                            height: 13.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            " 09:00-16:00",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18.w,
                          ),
                          Image(
                            image: AssetImage("images/geo-alt 1.png"),
                            height: 15.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            "25 m - Al Barsha 1, Al Rabwah, Shop No. 11",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
