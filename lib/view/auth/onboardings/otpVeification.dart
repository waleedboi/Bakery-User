import 'dart:async';
import 'dart:developer';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-otpver.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/newpassword.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/otpSuccessful.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// ignore: must_be_immutable
class OTPVerificationWidget extends StatefulWidget {
  bool isresetpassword;
  String id;

  OTPVerificationWidget({
    super.key,
    required this.isresetpassword,
    required this.id,
  });

  @override
  State<OTPVerificationWidget> createState() => _OTPVerificationWidgetState();
}

class _OTPVerificationWidgetState extends State<OTPVerificationWidget> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  void initState() {
    OtpVerController.obj.otpController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<OtpVerController>(builder: (obj) {
          return Container(
            height: ScreenUtil().screenHeight,
            width: ScreenUtil().screenWidth,
            color: const Color(0xffEEEEE6),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 55.h,
                  ),
                  AppBarClass(
                    text: 'OTP Verification',
                    color: const Color(0xff20402A),
                    iconcolor: const Color(0xff1B4332),
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  const Image(
                      image: AssetImage("images/shield-lock (1) 1.png")),
                  SizedBox(
                    height: 33.h,
                  ),
                  Text(
                    "Enter the 4 digit OTP sent to your email",
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
                    child: GetBuilder<OtpVerController>(
                        id: 'updatingfuncID',
                        builder: (obj) {
                          return PinCodeTextField(
                            validator: (value) {
                              if (value!.length < 4) {
                                return "WRONG OTP";
                              }
                              return null;
                            },
                            appContext: context,
                            length: 4,
                            animationType: AnimationType.fade,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            pinTheme: PinTheme(
                              selectedColor: AppColors.primaryColor,
                              selectedFillColor: Colors.white,
                              errorBorderColor: const Color(0xffE71616),
                              activeBorderWidth: 1.w,
                              inactiveBorderWidth: 1.w,
                              errorBorderWidth: 1.w,
                              inactiveColor:
                                  AppColors.primaryColor.withOpacity(0.3),
                              inactiveFillColor: Colors.white,
                              activeColor: AppColors.primaryColor,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 66.43.h,
                              fieldWidth: 66.31.w,
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: AppColors.primaryColor,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            textStyle: TextStyle(
                              fontSize: 26.sp,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                            enableActiveFill: true,
                            errorAnimationController: errorController,
                            controller: obj.otpController,
                            keyboardType: TextInputType.number,
                            onChanged: (v) {
                              obj.updatingfunc();
                            },
                            onCompleted: (v) {},
                          );
                        }),
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
                      width: 119.w,
                      height: 36.27.h,
                      onPressed: () async {
                        if (formkey.currentState!.validate() &&
                            obj.otpController.text.length == 4) {
                          bool isValidOtp = await EmailOTP.verifyOTP(
                              otp: obj.otpController.text);

                          if (isValidOtp) {
                            if (widget.isresetpassword == true) {
                              Get.to(() => NewPasswordScreen(id: widget.id));
                            } else {
                              Get.to(() => const OtpSuccessScreen());
                            }
                          } else {
                            log('Invalid OTP: ${obj.otpController.text}');
                            errorController.add(ErrorAnimationType.shake);
                            Get.snackbar("Error", "Invalid OTP entered",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        } else {
                          errorController.add(ErrorAnimationType.shake);
                        }
                      },
                      backcolor: obj.otpController.text.length == 4
                          ? ButtonsColors.secondaryColor
                          : Colors.grey,
                      child: ButtonText(
                        color: const Color(0xffFBFBF0),
                        text: 'Verify',
                        Font: FontWeight.w600,
                        fontsize: 13.62.sp,
                      )),
                  SizedBox(
                    height: 17.h,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}
