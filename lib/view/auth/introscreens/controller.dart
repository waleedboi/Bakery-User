import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreenController extends GetxController {
  static IntroScreenController get obj => Get.find();

  PageController pageController = PageController();
  int index = 0;

  void movemypagefunction(int value) {
    index = value;
    update(['dots']);
  }
}
