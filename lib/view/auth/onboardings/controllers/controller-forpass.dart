import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/models/user_model.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/otpVeification.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassController extends GetxController {
  static ForgotPassController get obj => Get.find();
  TextEditingController emailcontroller = TextEditingController();

  void resetpassfunc() {
    update(['resetpassfuncID']);
  }

  void forgotpass(UserModel model, BuildContext context) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> value =
          await FirebaseFirestore.instance
              .collection("users")
              .where("email", isEqualTo: emailcontroller.text.trim())
              .get();

      if (value.docs.isNotEmpty) {
        UserModel model = UserModel.fromMap(value.docs.first.data());

        if (await EmailOTP.sendOTP(email: model.email!)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("OTP has been sent"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          );

          Get.to(
            () => OTPVerificationWidget(
              id: model.id!,
              isresetpassword: true,
            ),
            transition: Transition.leftToRight,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("OTP failed to send"),
              backgroundColor: Colors.orange,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.error, color: Colors.white),
                SizedBox(width: 8),
                Text("Email is not registered"),
              ],
            ),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
