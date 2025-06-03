import 'dart:developer';
import 'package:completefoodorderingappui/bakeryadminapp/HomeScreens/home.dart';
import 'package:completefoodorderingappui/bakeryadminapp/HomeScreens/provider/user_provider.dart';
import 'package:completefoodorderingappui/bakeryadminapp/manage_orders/manage_orders.dart';
import 'package:completefoodorderingappui/bakeryadminapp/notifications/notifications_screen.dart';
import 'package:completefoodorderingappui/bakeryadminapp/profile_screen/admin_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AdminBottomBarScreen extends StatefulWidget {
  const AdminBottomBarScreen({super.key});

  @override
  State<AdminBottomBarScreen> createState() => _AdminBottomBarScreenState();
}

class _AdminBottomBarScreenState extends State<AdminBottomBarScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchCurrentUserData();
  }
  PageController pagecontroller = PageController();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffEEEEE6),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Stack(
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (value) {
                  log("message $value");
                  index = value;
                  setState(() {});
                },
                controller: pagecontroller,
                children: const [
                  HomeScreen(),
                  NotificationsScreen(),
                  ManageOrdersScreen(),
                  AdminProfileScreen(),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70.82.h,
                width: 371.27.w,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border.fromBorderSide(BorderSide(
                      color: Color.fromARGB(255, 182, 182, 182),
                    )
                        //color: Colors.grey,
                        )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        index = 0;
                        pagecontroller.jumpToPage(0);
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Center(
                          child: Image(
                            image: index != 0
                                ? const AssetImage("images/bottomnav.png")
                                : const AssetImage("images/homefilled.png"),
                            height: 16.h,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        index = 1;
                        pagecontroller.jumpToPage(1);
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Center(
                          child: Image(
                            image: index != 1
                                ? const AssetImage("images/bottomheart.png")
                                : const AssetImage("images/favfilled.png"),
                            height: 16.h,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        index = 2;
                        pagecontroller.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Center(
                          child: Image(
                            image: index != 2
                                ? const AssetImage("images/bottomkitchen.png")
                                : const AssetImage("images/Ordersfilled.png"),
                            height: 16.h,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        index = 3;
                        pagecontroller.jumpToPage(3);
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox(
                        width: 60.w,
                        height: 60.h,
                        child: Center(
                          child: Image(
                            image: index != 3
                                ? const AssetImage("images/bottomprofile.png")
                                : const AssetImage(
                                    "images/profilefilled (2).png"),
                            height: 16.h,
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
      ),
    );
  }
}
