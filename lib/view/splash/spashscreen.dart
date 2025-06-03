import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/bakeryadminapp/admin_bottom_bar/admin_bottom_bar.dart';
import 'package:completefoodorderingappui/view/auth/introscreens/controller.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-createAnAccount.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-forpass.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-newpass.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-otpver.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-signin.dart';
import 'package:completefoodorderingappui/view/boarding/on_boarding.dart';
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
import 'package:permission_handler/permission_handler.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _askPermissions();
    requestNotificationPermission();

    Future.delayed(const Duration(seconds: 3), () async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.offAll(() => const OnboardingScreen());
        return;
      }

      final uid = user.uid;

      final adminDoc =
          await FirebaseFirestore.instance.collection('admins').doc(uid).get();
      if (adminDoc.exists) {
        Get.offAll(() => const AdminBottomBarScreen());
        return;
      }

      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      final verified = userDoc.data()?['otpVerified'] as bool? ?? false;

      if (verified) {
        // Initialize user-specific controllers
        Get.put(MyInfoController());
         Get.offAll(() => const BottomBarScreen());
      } else {
        Get.offAll(() => const OnboardingScreen());
      }
    });
  }

  void _initializeControllers() {
    // Initialize common controllers
    Get.put(OtpVerController());
    Get.put(SplashScreenController());
    Get.put(FavoritiesController());
    Get.put(IntroScreenController());
    Get.put(SigninController());
    Get.put(NewPassController());
    Get.put(ForgotPassController());
    Get.put(CreateAnAccountController());
  }

  Future<void> _askPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
      Permission.photos,
      Permission.storage,
      Permission.mediaLibrary,
    ].request();

    statuses.forEach((permission, status) {
      if (status.isDenied || status.isPermanentlyDenied) {
        print('$permission denied');
      }
    });
  }

  Future<void> requestNotificationPermission() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
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
                      height: 200.h,
                      width: 200.h,
                      child:
                          const Image(image: AssetImage("images/fullLogo.png")),
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
