import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/forgetpassword.dart';
import 'package:completefoodorderingappui/homescreenlist.dart';
import 'package:completefoodorderingappui/otpVeification.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  bool iconclicked = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
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
              AppBarClass(text: "Sign In", color: Color(0xff20402A), iconcolor: Color(0xff1B4332),),
              SizedBox(
                height: 150.h,
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
                },  align: TextAlign.start,
              ),
              SizedBox(
                height: 18.h,
              ),
              InkWell(
                onTap: (){
                 
                  Get.to(() => ForgotPasswordScreen(),);
                },
                child: Container(
                    width: ScreenUtil().screenWidth*0.85,
                  child: Text("Forget Password?",
                      textAlign: TextAlign.end,
                    
                      style: TextStyle(
                        fontSize: 13.62.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 110.h,
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
                        Get.to(() => HomeScreenListScreen(),
                            transition: Transition.leftToRight);
                      }
                    },
                    backcolor:
                            emailcontroller.text.isNotEmpty &&
                            passwordcontroller.text.isNotEmpty 
                           
                        ? ButtonsColors.secondaryColor
                        : Colors.grey),
              SizedBox(
                height: 40.h,
              ),
              
              
                  Text(
                "Didn’t have any accounts? Click here to\n create new",
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
