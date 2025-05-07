import 'dart:developer';

import 'package:completefoodorderingappui/view/auth/introscreens/controller.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/view/auth/introscreens/introScreen1.dart';
import 'package:completefoodorderingappui/view/auth/introscreens/introScreen2.dart';
import 'package:completefoodorderingappui/view/auth/introscreens/introScreen3.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/loginsignup.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IntroScreenPaging extends StatefulWidget {
  const IntroScreenPaging({super.key});

  @override
  State<IntroScreenPaging> createState() => _IntroScreenPagingState();
}

class _IntroScreenPagingState extends State<IntroScreenPaging> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IntroScreenController>(builder: (obj) {
        log("main builder ---");
        return Container(
          height: 756.h,
          width: 375.w,
          color: const Color(0xffEEEEE6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<IntroScreenController>(
                  id: 'dots',
                  builder: (obj) {
                    log("row builder ---");
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 6.h,
                          width: obj.index != 0 ? 15.w : 37.w,
                          decoration: BoxDecoration(
                            color: obj.index != 0
                                ? const Color(0xffCDCDCD)
                                : const Color(0xff1B4332),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          height: 6.h,
                          width: obj.index == 1 ? 37.w : 15.w,
                          decoration: BoxDecoration(
                            color: obj.index == 1
                                ? const Color(0xff1B4332)
                                : const Color(0xffCDCDCD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Container(
                          height: 6.h,
                          width: obj.index == 2 ? 37.w : 15.w,
                          decoration: BoxDecoration(
                            color: obj.index == 2
                                ? const Color(0xff1B4332)
                                : const Color(0xffCDCDCD),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11.r)),
                          ),
                        ),
                      ],
                    );
                  }),
              Container(
                height: 400.h,
                width: ScreenUtil().screenWidth,
                child: PageView(
                  controller: obj.pageController,
                  onPageChanged: (value) {
                    obj.movemypagefunction(value);
                  },
                  children: [
                    //1
                    const IntroScreen1(),

                    const IntroScreen2(),

                    const IntroScreen3(),
                  ],
                ),
              ),
              GetBuilder<IntroScreenController>(
                  id: 'dots',
                  builder: (obj) {
                    return CustomButtons(
                      borderRadius: obj.index == 2 ? 13.r : 28.r,
                      width: obj.index == 2 ? 296.w : 68.w,
                      height: 68.h,
                      onPressed: () {
                        obj.pageController.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.easeIn);
                      },
                      backcolor: AppColors.primaryColor,
                      child: obj.index == 2
                          ? TextButton(
                              onPressed: () {
                                // Get.to(() => const LoginSignupPage(),
                                //     transition: Transition.leftToRight);
                                // setState(() {});
                              },
                              child: ButtonText(
                                color: Colors.white,
                                text: "Get Started",
                                Font: FontWeight.w600,
                                fontsize: 16.sp,
                              ))
                          : const Icon(
                              Icons.arrow_forward,
                              color: Color(0xffF4F6FF),
                            ),
                    );
                  })
            ],
          ),
        );
      }),
    );
  }
}
