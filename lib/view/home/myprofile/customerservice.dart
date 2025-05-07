import 'package:completefoodorderingappui/view/home/myprofile/contactsupportform.dart';
import 'package:completefoodorderingappui/view/home/myprofile/faq.dart';
import 'package:completefoodorderingappui/view/change_password/change_password.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Container(
        color: Color(0xffEEEEE6),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            AppBarClass(
              text: 'Customer Service',
              color: Color(0xff20402A),
              iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 31.h,
            ),
            InkWell(
              onTap: (){
                Get.to(() => ContactSupportFormScreen());
              },
              child: Container(
                width: 325.5.w,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("images/Group 14086.png"),
                      height: 39.h,
                      width: 39.w,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "Contact Support",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xff20402A),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              height: 1.h,
              width: 325.5.w,
              color: Color(0xffCDD2C8),
            ),
            SizedBox(
              height: 11.h,
            ),
            InkWell(
              onTap: (){
                Get.to(() => FAQScreen());
              },
              child: Container(
                width: 325.5.w,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage("images/Group 14087.png"),
                      height: 39.h,
                      width: 39.w,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "FAQs",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                      ),
                    ),
                    Spacer(),
                    // SizedBox(
                    //   width: 107.w,
                    // ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xff20402A),
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