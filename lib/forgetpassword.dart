import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/otpVeification.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailcontroller = TextEditingController();
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
                text: 'Reset Password', color: Color(0xff20402A), iconcolor: Color(0xff1B4332),
              ),
              SizedBox(
                height: 177.h,
              ),
              TextFormFieldWidget(
                onChanged: (v) {
                  setState(() {});
                },
                textEditingController: emailcontroller,
                text: "Enter your registered Email",
                width: 319.w,
                align: TextAlign.center,
                validator: (value) {
                  bool emailcontroller = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value!);
                  if (value!.isEmpty) {
                    return "Please enter Email";
                  }
                  if (!emailcontroller) {
                    return "Please enter valid Email";
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 49.h,
              ),
              CustomButtons(
                  borderRadius: 7.78.r,
                  child: ButtonText(
                    color: Color(0xffFBFBF0),
                    text: 'Proceed',
                    Font: FontWeight.w600,
                    fontsize: 13.62.sp,
                  ),
                  width: 119.w,
                  height: 36.27.h,
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Get.to(() => OTPVerificationWidget(
                        isresetpassword: true,
                      ),
                          transition: Transition.leftToRight);
                    }
                  },
                  backcolor: emailcontroller.text.isNotEmpty
                      ? ButtonsColors.secondaryColor
                      : Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
