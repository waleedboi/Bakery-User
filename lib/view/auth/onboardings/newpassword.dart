import 'package:completefoodorderingappui/view/auth/onboardings/controllers/controller-newpass.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class NewPasswordScreen extends StatefulWidget {
  String id;

  NewPasswordScreen({super.key, required this.id});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<NewPassController>(builder: (obj) {
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
                  text: 'New Password',
                  color: const Color(0xff20402A),
                  iconcolor: const Color(0xff1B4332),
                ),
                SizedBox(
                  height: 120.h,
                ),
                GetBuilder<NewPassController>(
                    id: 'newpassfuncID',
                    builder: (obj) {
                      return TextFormFieldWidget(
                        onChanged: (v) {},
                        textEditingController: obj.passwordcontroller,
                        text: "Password",
                        width: 319.w,
                        obscureText: obj.iconclickedpassword,
                        obscuringCharacter: "*",
                        suffixicon: IconButton(
                          onPressed: () {
                            obj.newpassfunc();
                          },
                          icon: Icon(
                              obj.iconclickedpassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(0.35)),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        align: TextAlign.start,
                        Fontsize: 16.sp,
                      );
                    }),
                SizedBox(
                  height: 29.h,
                ),
                GetBuilder<NewPassController>(
                    id: 'confpassfuncID',
                    builder: (obj) {
                      return TextFormFieldWidget(
                        onChanged: (v) {},
                        textEditingController: obj.confirmpasswordcontroller,
                        text: "Confirm Password",
                        width: 319.w,
                        obscureText: obj.iconclickedconfirmpassword,
                        obscuringCharacter: "*",
                        suffixicon: IconButton(
                          onPressed: () {
                            obj.confpassfunc();
                          },
                          icon: Icon(
                            obj.iconclickedconfirmpassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color:
                                const Color.fromARGB(255, 0, 0, 0).withOpacity(0.35),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          } else if (obj.passwordcontroller.text != value) {
                            return "Confirm password does not match";
                          }
                          return null;
                        },
                        align: TextAlign.start,
                        Fontsize: 16.sp,
                      );
                    }),
                SizedBox(
                  height: 100.h,
                ),
                CustomButtons(
                    borderRadius: 7.78.r,
                    width: 119.w,
                    height: 36.27.h,
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        obj.updatepassword(
                            password: obj.passwordcontroller.text,
                            id: widget.id);
                      }
                    },
                    backcolor: obj.passwordcontroller.text.isNotEmpty &&
                            obj.confirmpasswordcontroller.text.isNotEmpty
                        ? ButtonsColors.secondaryColor
                        : Colors.grey,
                    child: ButtonText(
                      color: const Color(0xffFBFBF0),
                      text: 'Proceed',
                      Font: FontWeight.w600,
                      fontsize: 13.62.sp,
                    )),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  "By proceeding you are accepting all our\n Terms & Conditions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13.62.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
