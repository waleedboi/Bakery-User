import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
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
              height: 55.h,
            ),
            AppBarClass(
              text: 'FAQs',
              color: Color(0xff20402A),
              iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 319.w,
              height: 577.h,
              child: SingleChildScrollView(
                  child: Column(
                      children: List.generate(
                6,
                (index) => 
                Column(
                 children: [
                       Text(
                      "1. Lorem ipsum dolor sit amet, consectur ?",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                 
               
               SizedBox(
                  height: 12.h,
                ),
                Container(
                  width: 290.w,
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla venena",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff696965))),
                ),
              SizedBox(
              height: 25.h,
            ),
                 ]
                 ))),
            )
          
        ),
  
    
          
    ]  ),
    ));
  }
}
