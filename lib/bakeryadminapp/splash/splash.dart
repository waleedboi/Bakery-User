import 'dart:async';
import 'package:completefoodorderingappui/bakeryadminapp/Auth/signup.dart';
import 'package:completefoodorderingappui/bakeryadminapp/admin_bottom_bar/admin_bottom_bar.dart';
import 'package:completefoodorderingappui/bakeryadminapp/profile_screen/controllers/my_info_controller.dart';
import 'package:completefoodorderingappui/bakeryadminapp/profile_screen/controllers/splash_controller.dart';
import 'package:completefoodorderingappui/view/home/myprofile/controllers/controller-myinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Get.put(MyInfoController());
    Get.put(SplashScreenController());
    _askPermissions();
    requestNotificationPermission();

    Timer(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminBottomBarScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminSignUpScreen()),
        );
      }
    });
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
      backgroundColor: const Color(0xFFDE5B33),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'images/splashimg.png',
              fit: BoxFit.cover,
            ),
          ),
          const Spacer(),
          const Text(
            'Food Ordering',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
