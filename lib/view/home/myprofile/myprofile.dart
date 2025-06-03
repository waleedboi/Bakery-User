import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/signin.dart';
import 'package:completefoodorderingappui/view/boarding/on_boarding.dart';
import 'package:completefoodorderingappui/view/home/myprofile/customerservice.dart';
import 'package:completefoodorderingappui/view/home/myprofile/myinfo.dart';
import 'package:completefoodorderingappui/view/change_password/change_password.dart';
import 'package:completefoodorderingappui/view/home/settingsscreens/setting.dart';
import 'package:completefoodorderingappui/view/widget/clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  String username = "";
  bool isLoading = true;
  String? userImageUrl;

  List<String> tabs = [
    "My Info",
    "Change Password",
    "Customer service",
    "Settings"
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        setState(() {
          username = userData['name'] ?? "User";
          userImageUrl = userData['imageurl'];
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Logout",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff1B4332),
            ),
          ),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Color(0xff1B4332)),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: Color(0xff1B4332),
                            ),
                            SizedBox(width: 16),
                            Text(
                              "Logging out...",
                              style: TextStyle(
                                color: Color(0xff1B4332),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                try {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    final token = await FirebaseMessaging.instance.getToken();

                    if (token != null) {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .update({
                        'tokens': FieldValue.arrayRemove([token]),
                      });
                    }
                  }
                  await FirebaseAuth.instance.signOut();
                  navigator.pop();

                  Get.offAll(() => const OnboardingScreen(initialPage: 2));
                } catch (e) {
                  navigator.pop();

                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      content: Text("Error logging out: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    if (userImageUrl != null && userImageUrl!.isNotEmpty) {
      return Container(
        width: 82.h,
        height: 82.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 212, 186, 168).withOpacity(0.3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 75.h,
            height: 75.h,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.network(
                userImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildInitialsContainer();
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: const Color(0xff1B4332),
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    } else {
      return _buildInitialsContainer();
    }
  }

  Widget _buildInitialsContainer() {
    String initial = username.isNotEmpty ? username[0].toUpperCase() : "U";

    return Container(
      width: 82.h,
      height: 82.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 212, 186, 168).withOpacity(0.3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 75.h,
          height: 75.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Center(
            child: Text(
              initial,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xff1B4332),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffFAFAFA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            if (index == 0) {
              final result = await Get.to(() => const MyInfoScreen());
              if (result == true) {
                fetchUserData();
              }
            } else if (index == 1) {
              Get.to(() => const ChangePassword());
            } else if (index == 2) {
              Get.to(() => const CustomerServiceScreen());
            } else {
              Get.to(() => const SettingScreen());
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff20402A),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.sp,
                    color: const Color(0xff1B4332),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: Stack(
        children: [
          ClipPath(
            clipper: TopClipper(),
            child: Container(
              height: 180.h,
              width: ScreenUtil().screenWidth,
              color: const Color(0xffF5DDCC),
            ),
          ),
          Positioned(
            top: 55.h,
            left: 20,
            right: 0,
            child: const Text(
              "My Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          Positioned(top: 100, right: 20, child: _buildProfileImage()),
          SafeArea(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff1B4332),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 90.h),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: const Color(0xff20402A),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Image(
                                    image: const AssetImage("images/hello.png"),
                                    height: 18.sp,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp,
                                  color: const Color(0xff1B4332),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Text(
                              "--------------------------",
                              style: TextStyle(
                                color: Color(0xffDE5B33),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        ...List.generate(
                          tabs.length,
                          (index) => _buildMenuItem(index),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 8.h),
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _showLogoutConfirmationDialog(context);
                            },
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          "App Version 1.0.0",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
