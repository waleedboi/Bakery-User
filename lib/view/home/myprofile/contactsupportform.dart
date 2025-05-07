import 'package:completefoodorderingappui/view/home/myprofile/contactsupport.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ContactSupportFormScreen extends StatefulWidget {
  const ContactSupportFormScreen({super.key});

  @override
  State<ContactSupportFormScreen> createState() => _ContactSupportFormScreenState();
}

class _ContactSupportFormScreenState extends State<ContactSupportFormScreen> {
  TextEditingController contactsupportcontroller = TextEditingController();

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
                text: "Contact Support",
                color: const Color(0xff20402A),
                iconcolor: const Color(0xff1B4332),
              ),
              SizedBox(
                height: 28.h,
              ),
             
              
              
              TextFormFieldWidget(
                onChanged: (v) {
                  setState(() {});
                },
                
                textEditingController: contactsupportcontroller,
              text: "Help us understand the problem",
                width: 319.w,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Name";
                  }
                  return null;
                },
                align: TextAlign.start, Fontsize: 15.sp, hinttext:'   Explain your queries here ...',
               
              ),
              SizedBox(
                height: 145.h,
              ),
                   CustomButtons(
                  borderRadius: 7.78.r,
                  child: ButtonText(
                    color: Color(0xffFBFBF0),
                    text: 'Submit',
                    Font: FontWeight.w600,
                    fontsize: 13.62.sp,
                  ),
                  width: 176.w,
                  height: 36.h,
                  onPressed: () {
                    Get.to(() => ContactSupportSuccessScreen());
  }, backcolor: Color(0xff20402A),),
       
         ],
          ),
        ),
      ),
 
    );
  }
}