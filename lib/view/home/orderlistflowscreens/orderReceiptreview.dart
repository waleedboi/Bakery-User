import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderReceiptReview extends StatefulWidget {
  int index;
  OrderReceiptReview({super.key, required this.index});

  @override
  State<OrderReceiptReview> createState() => _OrderReceiptReviewState();
}

class _OrderReceiptReviewState extends State<OrderReceiptReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: Color(0xffEEEEE6),
        child: Column(
          children: [
            SizedBox(
              height: 203.h,
            ),
            Image(
              image: AssetImage("images/smileReview.png"),
              height: 125.h,
              width: 125.w,
            ),
            SizedBox(
              height: 39.h,
            ),
            Text(
              "Thank You!",
              style: TextStyle(
                fontSize: 20.34.sp,
                fontWeight: FontWeight.w600,
                color: ButtonsColors.secondaryColor,
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Text(
              "Your review has been saved!",
              style: TextStyle(
                fontSize: 12.71.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff1B1B1B),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: widget.index >= index
                      ? ButtonsColors.secondaryColor
                      : Color(0xffD9D9D9),
                  size: 35.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
