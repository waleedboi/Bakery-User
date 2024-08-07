import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/clipper.dart';
import 'package:completefoodorderingappui/createAnAccount.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: Color(0xffB7B38F),
        child: Column(
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: TopClipper(),
                  child: Container(
                    height: 348.h,
                    width: ScreenUtil().screenWidth,
                    color: Color(0xffABA784),
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: TopClipper(),
                          child: Container(
                            height: 309.h,
                            width: ScreenUtil().screenWidth,
                            color: Color(0xff908D6A),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 39),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Stack(
                                  children: [
                                    Text(
                                      "Let's fight\n food waste\n together",
                                      style: TextStyle(
                                          fontSize: 33.11.h,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xffFFFFFF)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 113.h,
            ),
            Container(
              height: 251.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonWithIcon(
                    image: 'images/flat-color-icons_google.png',
                    text: 'Login with Apple',
                    onPressed: () {
                      Get.to(() => CreateAnAccount(),
                          transition: Transition.leftToRight);
                    },
                  ),
                  ButtonWithIcon(
                    image: 'images/Group 13353.png',
                    text: 'Login with Facebook',
                    onPressed: () {
                      Get.to(() => CreateAnAccount(),
                          transition: Transition.leftToRight);
                    },
                  ),
                  ButtonWithIcon(
                    image: 'images/Group 13353 (2).png',
                    text: 'Login with Gmail',
                    onPressed: () {
                      Get.to(() => CreateAnAccount(),
                          transition: Transition.leftToRight);
                    },
                  ),
                  ButtonWithIcon(
                    image: 'images/Group 13353 (3).png',
                    text: 'Login with Email',
                    onPressed: () {
                      Get.to(() => CreateAnAccount(),
                          transition: Transition.leftToRight);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
