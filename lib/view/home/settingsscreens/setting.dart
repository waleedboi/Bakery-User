import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/signin.dart';
import 'package:completefoodorderingappui/view/home/settingsscreens/privacypolicy.dart';
import 'package:completefoodorderingappui/view/home/settingsscreens/termandconditions.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
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
            SizedBox(
              height: 11.h,
            ),
            InkWell(
              onTap: () {
                Get.defaultDialog(
                  title: "Delete Account",
                  middleText:
                      "Are you sure you want to delete your account? This action is irreversible and your data will be permanently removed. You will not be able to log in with the same credentials again.",
                  confirm: TextButton(
                    onPressed: () async {
                      try {
                        final user = FirebaseAuth.instance.currentUser;
                        final uid = user?.uid;

                        if (uid != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .delete();

                          await user!.delete();

                          Get.offAll(const SignInScreen());
                        }
                      } catch (e) {
                        Get.snackbar("Error",
                            "Failed to delete account. Please try again.");
                      }
                    },
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.red)),
                  ),
                  cancel: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel"),
                  ),
                );
              },
              child: SizedBox(
                width: 325.5.w,
                child: Row(
                  children: [
                    Container(
                      width: 39.w,
                      height: 39.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red.withOpacity(0.3)),
                      child: const Center(
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 13.w,
                    ),
                    Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff000000),
                      ),
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
