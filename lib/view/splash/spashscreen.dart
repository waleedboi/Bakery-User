import 'package:completefoodorderingappui/view/auth/introscreens/controller.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/signin.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-createAnAccount.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-forpass.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-newpass.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-otpver.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-signin.dart';
import 'package:completefoodorderingappui/view/home/homescreens/controller.dart';
import 'package:completefoodorderingappui/view/bottombar/bottombar.dart';
import 'package:completefoodorderingappui/view/home/myprofile/controllers/controller-myinfo.dart';
import 'package:completefoodorderingappui/view/splash/controller.dart';
import 'package:completefoodorderingappui/view/widget/clipper.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {

  @override
  void initState() {
    super.initState();

    Get.put(OtpVerController());
    Get.put(SplashScreenController());
    Get.put(FavoritiesController());
    Get.put(IntroScreenController());
    Get.put(SigninController());
    Get.put(NewPassController());
    Get.put(ForgotPassController());
    Get.put(CreateAnAccountController());
    Get.put(MyInfoController());
    requestNotificationPermission();

    Future.delayed(const Duration(seconds: 3), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomBarScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      }
    });
  }

    Future<void> requestNotificationPermission() async {
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
    print('User denied permission');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              color: const Color(0xffDE5B33),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: 150.66.h,
                      width: 94.98.h,
                      child: const Image(image: AssetImage("images/g14.png")),
                    ),
                  ),
                  ClipPath(
                    clipper: TopClipper(),
                    child: Container(
                      height: 150.h,
                      width: 375.w,
                      color: AppColors.primaryColor,
                      child: Stack(children: [
                        SizedBox(
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
                                  SizedBox(
                                    height: 10.67.h,
                                    width: 17.w,
                                    child: const Image(
                                      image: AssetImage(
                                        "images/Mobile Signal.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  SizedBox(
                                    height: 10.97.h,
                                    width: 17.w,
                                    child: const Image(
                                      image: AssetImage(
                                        "images/Wifi.png",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  SizedBox(
                                    height: 11.33.h,
                                    width: 24.33.w,
                                    child: const Image(
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
