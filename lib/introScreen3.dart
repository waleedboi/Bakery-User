import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen3 extends StatefulWidget {
  const IntroScreen3({super.key});

  @override
  State<IntroScreen3> createState() => _IntroScreen3State();
}

class _IntroScreen3State extends State<IntroScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // height: 756.h,
      // width: 375.w,
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      color: Color(0xffEEEEE6),
      child: Column(
        children: [
          SizedBox(
            height: 90.h,
          ),
          Container(
            child: Image(
              image: AssetImage(
                "images/Group 14069.png",
              ),
              height: 165.h,
              width: 130.64.w,
            ),
          ),
          SizedBox(
            height: 32.h,
          ),
          Text(
            "Save Planet",
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
            "Make a sustainable difference with",
            style: TextStyle(
              color: Color(0xff4A4A47),
              fontSize: 14.h,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "every meal you choose with Takkul",
            style: TextStyle(
              color: Color(0xff4A4A47),
              fontSize: 14.h,
              fontWeight: FontWeight.w500,
            ),
          ),
          // SizedBox(
          //   height: 84.h,
          // ),
        ],
      ),
    ));
  }
}
