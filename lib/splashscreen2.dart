import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/clipper.dart';
import 'package:completefoodorderingappui/introScreen1.dart';
import 'package:completefoodorderingappui/introscreens.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              color: Color(0xffDE5B33),
              child: Stack(
                children: [
                  ClipPath(
                    clipper: TopClipper(),
                    child: Container(
                      height: 756.h,
                      width: 375.w,
                      color: AppColors.primaryColor,
                      child: Stack(children: [
                        Center(
                          child: Container(
                            height: 150.66.h,
                            width: 94.98.h,
                            child: Image(image: AssetImage("images/g14.png")),
                          ),
                        ),
                        Container(
                          height: 44.h,
                          width: 375.w,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                "9:41",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.09.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 275.w,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 10.67.h,
                                    width: 17.w,
                                    child: Image(
                                      image: AssetImage(
                                        "images/Mobile Signal.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Container(
                                    height: 10.97.h,
                                    width: 17.w,
                                    child: Image(
                                      image: AssetImage(
                                        "images/Wifi.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Container(
                                    height: 11.33.h,
                                    width: 24.33.w,
                                    child: Image(
                                      image: AssetImage(
                                        "images/Battery.png",
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 450.h,
                          ),
                          child: Center(
                            child: CustomButtons(
                              onPressed: () {
                                Get.to(() => IntroScreenPaging(),
                                    transition: Transition.leftToRight);
                              },
                              borderRadius: 100,
                              width: 270.w,
                              height: 51.h,
                              backcolor: Color(0xffFFFFFF),
                              child: ButtonText(
                                color: Color(0xff000000),
                                text: "Continue",
                                Font: FontWeight.w600, fontsize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 635, left: 20),
                            child: Container(
                              height: 17.h,
                              width: 220.w,
                              child: Row(
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    "Click here",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
