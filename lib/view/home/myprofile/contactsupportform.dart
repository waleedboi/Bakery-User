import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:completefoodorderingappui/view/home/myprofile/contactsupport.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactSupportFormScreen extends StatefulWidget {
  const ContactSupportFormScreen({super.key});

  @override
  State<ContactSupportFormScreen> createState() => _ContactSupportFormScreenState();
}

class _ContactSupportFormScreenState extends State<ContactSupportFormScreen> {
  final TextEditingController contactsupportcontroller = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> submitQuery() async {
    final queryText = contactsupportcontroller.text.trim();
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in.")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('queries').add({
        'query': queryText,
        'userId': currentUser.uid,
        'createdAt': Timestamp.now(),
      });

      Get.to(() => const ContactSupportSuccessScreen());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Query submitted successfully.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: const Color(0xffEEEEE6),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 55.h),
              AppBarClass(
                text: "Contact Support",
                color: const Color(0xff20402A),
                iconcolor: const Color(0xff1B4332),
              ),
              SizedBox(height: 28.h),
              TextFormFieldWidget(
                onChanged: (v) => setState(() {}),
                textEditingController: contactsupportcontroller,
                text: "Help us understand the problem",
                width: 319.w,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please explain your problem";
                  }
                  return null;
                },
                align: TextAlign.start,
                Fontsize: 15.sp,
                hinttext: 'Explain your queries here ...',
              ),
              SizedBox(height: 20.h),
              CustomButtons(
                borderRadius: 7.78.r,
                width: 176.w,
                height: 36.h,
                onPressed: isLoading
                    ? null
                    : () {
                        if (formkey.currentState!.validate()) {
                          submitQuery();
                        }
                      },
                backcolor: const Color(0xff20402A),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    : ButtonText(
                        color: const Color.fromARGB(255, 245, 245, 240),
                        text: 'Submit',
                        Font: FontWeight.w600,
                        fontsize: 13.62.sp,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
