import 'dart:async';

import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/createAnAccount.dart';
import 'package:completefoodorderingappui/newpassword.dart';
import 'package:completefoodorderingappui/otpSuccessful.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationWidget extends StatefulWidget {
  bool isresetpassword;
  OTPVerificationWidget({
    super.key,
    required this.isresetpassword,
  });

  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      color: Color(0xffEEEEE6),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            AppBarClass(
              text: 'OTP Verification', color: Color(0xff20402A), iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 45.h,
            ),
            Image(image: AssetImage("images/shield-lock (1) 1.png")),
            SizedBox(
              height: 33.h,
            ),
            Text(
              "Enter the 6 digit OTP sent to email \n am******@***.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Text(
              "OTP",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
              ),
              child: PinCodeTextField(
                validator: (value) {
                  if (value!.length < 4) {
                    return "WRONG OTP";
                  }
                },
                appContext: context,
                length: 4,
                animationType: AnimationType.fade,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                pinTheme: PinTheme(
                  selectedColor: AppColors.primaryColor,
                  selectedFillColor: Colors.white,
                  errorBorderColor: const Color(0xffE71616),
                  activeBorderWidth: 1.w,
                  inactiveBorderWidth: 1.w,
                  errorBorderWidth: 1.w,
                  inactiveColor: AppColors.primaryColor.withOpacity(0.3),
                  inactiveFillColor: Colors.white,
                  activeColor: AppColors.primaryColor,
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 66.43.h,
                  fieldWidth: 66.31.w,
                  activeFillColor: Colors.white,
                ),
                cursorColor: AppColors.primaryColor,
                animationDuration: const Duration(milliseconds: 300),
                textStyle: TextStyle(
                  fontSize: 26.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: otpController,
                keyboardType: TextInputType.number,
                onChanged: (v) {
                  setState(() {});
                },
                onCompleted: (v) {},
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Text(
              "Didn’t Received the OTP. \n Click here to resend",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            CustomButtons(
                borderRadius: 7.78.r,
                child: ButtonText(
                  color: Color(0xffFBFBF0),
                  text: 'Verify',
                  Font: FontWeight.w600,
                  fontsize: 13.62.sp,
                ),
                width: 119.w,
                height: 36.27.h,
                onPressed: () {
                  if (formkey.currentState!.validate() &&
                      otpController.text.length == 4) {
                    if (widget.isresetpassword == true) {
                      Get.to(() =>NewPasswordScreen (),
                          transition: Transition.leftToRight);
                    } else {
                      Get.to(() => OtpSuccessScreen(),
                          transition: Transition.leftToRight);
                    }
                  } else {
                    errorController.add(ErrorAnimationType.shake);
                  }
                },
                backcolor: otpController.text.length == 4
                    ? ButtonsColors.secondaryColor
                    : Colors.grey),
            SizedBox(
              height: 17.h,
            ),
            Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff20402A)),
              child: Center(
                child: Text(
                  "Or",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Text(
              "Click the link receive in your email to \n connect",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
