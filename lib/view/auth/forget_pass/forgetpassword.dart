import 'package:completefoodorderingappui/models/user_model.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-forpass.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPassController forgotPassController = Get.put(ForgotPassController());
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ForgotPassController>(builder: (obj) {
        return Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          color: const Color(0xffEEEEE6),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(height: 55.h),
                AppBarClass(
                  text: 'Reset Password',
                  color: const Color(0xff20402A),
                  iconcolor: const Color(0xff1B4332),
                ),
                SizedBox(height: 177.h),
                TextFormFieldWidget(
                  onChanged: (v) {
                    obj.resetpassfunc();
                  },
                  textEditingController: obj.emailcontroller,
                  text: "Enter your registered Email",
                  width: 319.w,
                  align: TextAlign.center,
                  validator: (value) {
                    bool emailcontroller = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) return "Please enter Email";
                    if (!emailcontroller) return "Please enter valid Email";
                    return null;
                  },
                  Fontsize: 16.sp,
                ),
                SizedBox(height: 49.h),
                GetBuilder<ForgotPassController>(
                  id: 'resetpassfuncID',
                  builder: (obj) {
                    return CustomButtons(
                      borderRadius: 7.78.r,
                      width: 119.w,
                      height: 36.27.h,
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          obj.forgotpass(
                            UserModel(email: obj.emailcontroller.text),
                            context,
                          );
                        }
                      },
                      backcolor: obj.emailcontroller.text.isNotEmpty
                          ? ButtonsColors.secondaryColor
                          : Colors.grey,
                      child: ButtonText(
                        color: const Color(0xffFBFBF0),
                        text: 'Proceed',
                        Font: FontWeight.w600,
                        fontsize: 13.62.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
