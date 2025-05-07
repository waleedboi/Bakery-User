

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/models/user_model.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/otpVeification.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAnAccountController extends GetxController {
  static CreateAnAccountController get obj => Get.find();
  TextEditingController textEditingController = TextEditingController();
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool iconclicked = false;

  void proceedfunction() {
    if (firstnamecontroller.text.isNotEmpty &&
        lastnamecontroller.text.isNotEmpty &&
        emailcontroller.text.isNotEmpty &&
        passwordcontroller.text.isNotEmpty &&
        confirmpasswordcontroller.text.isNotEmpty) {
      update(['proceedFunctionID']);
    }
  }

  void passwordfunction() {
    update(['passwordFunctionID']);
  }

  void confirmpasswordfunction() {
    update(['confpassFuncID']);
  }

  void createaccount(UserModel model, BuildContext context) async {
    // get all users

    FirebaseFirestore.instance
        .collection("user")
        .where("email", isEqualTo: model.email)
        .get()
        .then(
      (value) async {
        if (value.docs.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("email already exist"),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          await FirebaseFirestore.instance
              .collection("user")
              .doc(model.id)
              .set(model.toMap());
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("created succesfully!"),
          //     duration: Duration(seconds: 2),
          //   ),d
          // );

          if (await EmailOTP.sendOTP(email: model.email!)) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP has been sent")));
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("OTP failed sent")));
          }

          Get.to(
              () => OTPVerificationWidget(
                    id: '',
                    isresetpassword: false,
                  ),
              transition: Transition.leftToRight);
        }
      },
    );
  }
}
