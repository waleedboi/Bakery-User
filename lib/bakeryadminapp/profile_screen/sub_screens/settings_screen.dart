import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/bakeryadminapp/Auth/signin.dart';
import 'package:completefoodorderingappui/bakeryadminapp/utilis/utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffEEEEE6),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            AppBarClass(
              text: 'Settings',
              color: const Color(0xff20402A),
              iconcolor: const Color(0xff1B4332),
            ),
            SizedBox(
              height: 31.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const PrivacyPolicyScreen());
              },
              child: SizedBox(
                width: 325.5.w,
                child: Row(
                  children: [
                    Image(
                      image: const AssetImage("images/Group 14083.png"),
                      height: 39.h,
                      width: 39.w,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "Our Privacy Policy",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff000000),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
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
              color: const Color(0xffCDD2C8),
            ),
            SizedBox(
              height: 11.h,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const TermsandConditionScreen());
              },
              child: SizedBox(
                width: 325.5.w,
                child: Row(
                  children: [
                    Image(
                      image: const AssetImage("images/Group 14084.png"),
                      height: 39.h,
                      width: 39.w,
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "Our Terms & Conditions",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff000000),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
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
              color: const Color(0xffCDD2C8),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
              text: 'Privacy Policy',
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
                child: Text(
                  "At BakeMe, we value your privacy. This Privacy Policy explains how we collect, use, and protect your personal information.\n\n"
                  "1. **Information Collection**: We may collect your name, contact number, address, and email for the purpose of processing orders and improving your experience.\n\n"
                  "2. **Use of Information**: The collected data is used to deliver your baked goods, notify you about order status, and offer personalized recommendations.\n\n"
                  "3. **Data Protection**: Your information is securely stored and is never shared with third parties except to fulfill orders (e.g., delivery partners).\n\n"
                  "4. **Cookies**: We may use cookies to enhance app functionality and improve your browsing experience.\n\n"
                  "5. **User Rights**: You have the right to request deletion of your data or ask how your data is being used.\n\n"
                  "By using the BakeMe app, you consent to our Privacy Policy. For questions, please contact us at support@bakeme.app.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TermsandConditionScreen extends StatefulWidget {
  const TermsandConditionScreen({super.key});

  @override
  State<TermsandConditionScreen> createState() =>
      _TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {
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
              text: 'Terms & Conditions',
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
                child: Text(
  "Welcome to BakeMe! These Terms & Conditions govern your use of our app and services.\n\n"
  "1. **Orders**: All orders placed through the app are subject to availability and confirmation.\n\n"
  "2. **Payments**: Prices displayed include applicable taxes. Payments must be completed before delivery.\n\n"
  "3. **Delivery**: BakeMe aims to deliver orders within the selected time slot. However, delays may occur due to unforeseen circumstances.\n\n"
  "4. **Cancellations & Refunds**: Orders can be canceled within 5 minutes of placing. Refunds are issued for eligible cancellations or issues.\n\n"
  "5. **Account Responsibility**: You are responsible for maintaining the confidentiality of your account and for all activities under it.\n\n"
  "6. **Modifications**: We reserve the right to update these terms at any time. Continued use of the app signifies your acceptance of the changes.\n\n"
  "Thank you for choosing BakeMe. We’re excited to bring delicious bakery items to your doorstep!",
  textAlign: TextAlign.justify,
  style: TextStyle(fontSize: 14.sp),
),
              ),
            )
          ],
        ),
      ),
    );
  }
}
