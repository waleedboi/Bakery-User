import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/models/user_model.dart';
import 'package:completefoodorderingappui/view/home/homescreenlist.dart';
import 'package:completefoodorderingappui/view/bottombar/bottombar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninController extends GetxController {
  static SigninController get obj => Get.find();
  bool iconclicked = false;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  void proceedfunc() {
    update(['proceedfuncID']);
  }

  void signin(UserModel model, BuildContext context) async {
    // get all users

    FirebaseFirestore.instance.collection("user").get().then(
      (value) {
        if (value.docs.isNotEmpty) {
          // map to model convert

          value.docs.forEach(
            (element) async {
              UserModel loopmodel = UserModel.fromMap(element.data());

              if (loopmodel.email == model.email) {
                if (loopmodel.password == model.password) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Login Successful!"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setString('id', loopmodel.id!);

                  Get.to(() => BottomBarScreen(),
                      transition: Transition.leftToRight);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(" Reenter password"),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Email doesnot match!"),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }




}
