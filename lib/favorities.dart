import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritiesScreen extends StatefulWidget {
  const FavoritiesScreen({super.key});

  @override
  State<FavoritiesScreen> createState() => _FavoritiesScreenState();
}

class _FavoritiesScreenState extends State<FavoritiesScreen> {
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
            height: 55.h,
          ),
         AppBarClass(text: "Your favourite stores", color: Color(0xff20402A), iconcolor: Color(0xff1B4332),),
          SizedBox(
            height: 63.h,
          ),
          Container(
            child: Image(
              image: AssetImage(
                "images/Group 13384.png",
              ),
              height: 157.h,
              width: 157.w,
            ),
          ),
          SizedBox(
            height: 56.h,
          ),
          Text(
            "Oops! You don’t have a\n  favourite store yet :(",
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
              "     Click on the heart of your favourite stores to\naccess them in one click and receive notifications\n                for each new basket published!",
              style: TextStyle(
                color: Color(0xff4A4A47),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonText(
                        color: Color(0xff20402A),
                        text: 'Go to Home Page',
                        Font: FontWeight.w500,
                        fontsize: 14.sp,
                      ),
                      
                    ],
                  ),
                  width: 306.04.w,
                  height: 42.h,
                  backcolor: Color(0xffE7EADE)),
          
        ],
      ),
    )

    );
  }
}