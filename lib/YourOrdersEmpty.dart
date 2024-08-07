import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YourOrdersEmptyScreen extends StatefulWidget {
  const YourOrdersEmptyScreen({super.key});

  @override
  State<YourOrdersEmptyScreen> createState() => _YourOrdersEmptyScreenState();
}

class _YourOrdersEmptyScreenState extends State<YourOrdersEmptyScreen> {
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
            height: 63.h,
          ),
          Container(
            child: Image(
              image: const AssetImage(
                "images/myorderempty.png",
              ),
              height: 157.h,
              width: 157.w,
            ),
          ),
          SizedBox(
            height: 56.h,
          ),
          Text(
            "You didn't save any",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.h,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "food yet!",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.h,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 21.h,
          ),
          Center(
            child: Text(
              "Order your favourite meals now!",
              style: TextStyle(
                color: const Color(0xff4A4A47),
                fontSize: 14.h,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 53.h,
          ),
          CustomButtons(
              onPressed: () {},
              borderRadius: 8.r,
              width: 306.04.w,
              height: 42.h,
              backcolor: const Color(0xffE7EADE),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonText(
                    color: const Color(0xff20402A),
                    text: 'Go to Home Page',
                    Font: FontWeight.w500,
                    fontsize: 14.sp,
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}
