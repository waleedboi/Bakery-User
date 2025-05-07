import 'package:completefoodorderingappui/view/home/myprofile/myprofile.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ContactSupportSuccessScreen extends StatefulWidget {
  const ContactSupportSuccessScreen({super.key});

  @override
  State<ContactSupportSuccessScreen> createState() => _ContactSupportSuccessScreenState();
}

class _ContactSupportSuccessScreenState extends State<ContactSupportSuccessScreen> {
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
              text: 'Contact Support',
              color: Color(0xff20402A),
              iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 112.h,
            ),
            Image(image: AssetImage("images/Group 14055.png")),
            SizedBox(
              height: 56.h,
            ),
            Text(
              "Success!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff20402A),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Text(
              "We have received your queries. Someone\n from our team will get back to you shortly.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff7D7D79),
              ),
            ),
             SizedBox(
              height: 36.h,
            ),
                CustomButtons(
              borderRadius: 7.78.r,
              child: ButtonText(
                color: Color(0xff20402A),
                text: 'Go to Home Page',
                Font: FontWeight.w500,
                fontsize: 14.sp,
              ),
              width: 277.w,
              height: 42.h,
              onPressed: () {
                Get.to(() => MyProfileScreen());
              },
              backcolor: Color(0xffE7EADE),
            ),
          
          ],
        ),
      ),
   
    );
  }
}