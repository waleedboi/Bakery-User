import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/passresetsuccessful.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassController extends GetxController {
  static NewPassController get obj => Get.find();

  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool iconclickedpassword = false;
  bool iconclickedconfirmpassword = false;
  void newpassfunc() {
    iconclickedpassword = !iconclickedpassword;
    update(['newpassfuncID']);
  }

  void confpassfunc() {
    iconclickedconfirmpassword = !iconclickedconfirmpassword;

    update(['confpassfuncID']);
  }

  void updatepassword({
    required String password,
    required String id,
  }) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(password);

      await FirebaseFirestore.instance
          .collection("user")
          .doc(id)
          .update({"lastPasswordReset": DateTime.now()});

      Get.to(() => const PassResetSuccessScreen(),
          transition: Transition.leftToRight);
    } catch (e) {
      Get.snackbar("Error", "Failed to update password $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }
}
