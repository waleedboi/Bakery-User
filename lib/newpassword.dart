import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/homescreenlist.dart';
import 'package:completefoodorderingappui/otpVeification.dart';
import 'package:completefoodorderingappui/passresetsuccessful.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool iconclicked = false;
  @override
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
                text: 'New Password', color: Color(0xff20402A), iconcolor: Color(0xff1B4332),
              ),
              SizedBox(
                height: 120.h,
              ),
              TextFormFieldWidget(
                onChanged: (v) {
                  setState(() {});
                },
                textEditingController: passwordcontroller,
                text: "Password",
                width: 319.w,
                obscureText: iconclicked,
                obscuringCharacter: "*",
                suffixicon: IconButton(
                  onPressed: () {
                    iconclicked = !iconclicked;
                    setState(() {});
                  },
                  icon: Icon(
                      iconclicked ? Icons.visibility : Icons.visibility_off,
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.35)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  }
                  return null;
                },
                align: TextAlign.start,
              ),
              SizedBox(
                height: 29.h,
              ),
              TextFormFieldWidget(
                onChanged: (v) {
                  setState(() {});
                },
                textEditingController: confirmpasswordcontroller,
                text: "Confirm Password",
                width: 319.w,
                obscureText: iconclicked,
                obscuringCharacter: "*",
                suffixicon: IconButton(
                  onPressed: () {
                    iconclicked = !iconclicked;
                    setState(() {});
                  },
                  icon: Icon(
                    iconclicked ? Icons.visibility : Icons.visibility_off,
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.35),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  } else if (passwordcontroller.text != value) {
                    return "Confirm password does not match";
                  }
                  return null;
                },
                align: TextAlign.start,
              ),
              SizedBox(
                height: 100.h,
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
                      Get.to(() => PassResetSuccessScreen(),
                          transition: Transition.leftToRight);
                    }
                  },
                  backcolor: passwordcontroller.text.isNotEmpty &&
                          confirmpasswordcontroller.text.isNotEmpty
                      ? ButtonsColors.secondaryColor
                      : Colors.grey),
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
      ),
    );
  }
}
