import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/introScreen1.dart';
import 'package:completefoodorderingappui/introScreen2.dart';
import 'package:completefoodorderingappui/introScreen3.dart';
import 'package:completefoodorderingappui/loginsignup.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IntroScreenPaging extends StatefulWidget {
  const IntroScreenPaging({super.key});

  @override
  State<IntroScreenPaging> createState() => _IntroScreenPagingState();
}

class _IntroScreenPagingState extends State<IntroScreenPaging> {
  PageController pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 756.h,
        width: 375.w,
        color: Color(0xffEEEEE6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 6.h,
                  width: index != 0 ? 15.w : 37.w,
                  decoration: BoxDecoration(
                    color: index != 0 ? Color(0xffCDCDCD) : Color(0xff1B4332),
                    borderRadius: BorderRadius.all(Radius.circular(11.r)),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  height: 6.h,
                  width: index == 1 ? 37.w : 15.w,
                  decoration: BoxDecoration(
                    color: index == 1 ? Color(0xff1B4332) : Color(0xffCDCDCD),
                    borderRadius: BorderRadius.all(Radius.circular(11.r)),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Container(
                  height: 6.h,
                  width: index == 2 ? 37.w : 15.w,
                  decoration: BoxDecoration(
                    color: index == 2 ? Color(0xff1B4332) : Color(0xffCDCDCD),
                    borderRadius: BorderRadius.all(Radius.circular(11.r)),
                  ),
                ),
              ],
            ),
            Container(
              height: 400.h,
              width: ScreenUtil().screenWidth,
              child: PageView(
                controller: pageController,
                onPageChanged: (value) {
                  print(value);
                  index = value;
                  setState(() {});
                },
                children: [
                  //1
                  IntroScreen1(),

                  IntroScreen2(),

                  IntroScreen3(),
                ],
              ),
            ),
            CustomButtons(
              borderRadius: index == 2 ? 13.r : 28.r,
              width: index == 2 ? 296.w : 68.w,
              height: 68.h,
              onPressed: () {
                pageController.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.easeIn);
              },
              backcolor: AppColors.primaryColor,
              child: index == 2
                  ? TextButton(
                      onPressed: () {
                        Get.to(() => LoginSignupPage(),
                            transition: Transition.leftToRight);
                        setState(() {});
                      },
                      child: ButtonText(
                        color: Colors.white,
                        text: "Get Started",
                        Font: FontWeight.w600,
                        fontsize: 16.sp,
                      ))
                  : Icon(
                      Icons.arrow_forward,
                      color: Color(0xffF4F6FF),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
