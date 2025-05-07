import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OtpVerController extends GetxController {
  static OtpVerController get obj => Get.find();

    TextEditingController otpController = TextEditingController();

    void updatingfunc(){
      update(['updatingfuncID']);
    }
}