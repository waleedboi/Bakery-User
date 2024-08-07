import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/otpVeification.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CreateAnAccount extends StatefulWidget {
 
  const CreateAnAccount({super.key
  });

  @override
  State<CreateAnAccount> createState() => _CreateAnAccountState();
}

class _CreateAnAccountState extends State<CreateAnAccount> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  bool iconclicked = false;
  
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
              AppBarClass(text: 'Create an account', color: Color(0xff20402A), iconcolor: Color(0xff1B4332),),
              SizedBox(
                height: 45.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 26.w,
                  ),
                  TextFormFieldWidget(
                    onChanged: (v) {
                      setState(() {});
                    },
                    textEditingController: firstnamecontroller,
                    text: "First Name",
                    width: 156.w,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter First Name";
                      }
                      return null;
                    }, align: TextAlign.start,
                  ),
                  SizedBox(
                    width: 25.w,
                  ),
                  TextFormFieldWidget(
                    onChanged: (v) {
                      setState(() {});
                    },
                    textEditingController: lastnamecontroller,
                    text: "Last Name",
                    width: 136.w,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Last Name";
                      }
                      return null;
                    }, align: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 29.h,
              ),
              TextFormFieldWidget(
                onChanged: (v) {
                  setState(() {});
                },
                textEditingController: emailcontroller,
                text: "Email",
                width: 319.w,
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
                }, align: TextAlign.start,
              ),
             
             
              SizedBox(
                height: 29.h,
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
                }, align: TextAlign.start,
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
                }, align: TextAlign.start,
              ),
              SizedBox(
                height: 50.h,
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
                        isresetpassword: false,
                      ),
                          transition: Transition.leftToRight);
                    }
                  },
                  backcolor: firstnamecontroller.text.isNotEmpty &&
                          lastnamecontroller.text.isNotEmpty &&
                          emailcontroller.text.isNotEmpty &&
                          passwordcontroller.text.isNotEmpty &&
                          confirmpasswordcontroller.text.isNotEmpty
                      ? ButtonsColors.secondaryColor
                      : Colors.grey),
           
           
              SizedBox(
                height: 40.h,
              ),
              Text(
                "By proceeding, you are accepting all\n our terms and conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.62.sp,
                  fontWeight: FontWeight.normal,
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

