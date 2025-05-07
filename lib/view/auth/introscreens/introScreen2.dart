import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen2 extends StatefulWidget {
  const IntroScreen2({super.key});

  @override
  State<IntroScreen2> createState() => _IntroScreen2State();
}

class _IntroScreen2State extends State<IntroScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: ScreenUtil().screenHeight,
      width: 375.w,
      color: Color(0xffEEEEE6),
      child: Column(
        children: [
          SizedBox(
            height: 140.h,
          ),
          Container(
            child: Image(
              image: AssetImage(
                "images/Group 14068.png",
              ),
              height: 118.h,
              width: 97.w,
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            "Save Money",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.h,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            "Savor your favorites at unbeatable",
            style: TextStyle(
              color: Color(0xff4A4A47),
              fontSize: 14.h,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "prices with Takkul",
            style: TextStyle(
              color: Color(0xff4A4A47),
              fontSize: 14.h,
              fontWeight: FontWeight.w500,
            ),
          ),
          // // SizedBox(
          //   height: 84.h,
          // ),
          // CustomButtons(
          //   borderRadius: 28.r,
          //   width: 68.w,
          //   height: 68.h,
          //   onPressed: () {},
          //   backcolor: AppColors.primaryColor,
          //   child: Icon(
          //     Icons.arrow_forward,
          //     color: Color(0xffF4F6FF),
          //   ),
          // )
        ],
      ),
    ));
  }
}
