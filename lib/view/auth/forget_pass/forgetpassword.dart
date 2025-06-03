import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void resetPassword(BuildContext context) async {
    final email = emailController.text.trim();
    setState(() => isLoading = true);

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No account found with this email.")),
        );
        setState(() => isLoading = false);
        return;
      }

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password reset link sent to your email.")),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong: $e")),
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
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 55.h),
              AppBarClass(
                text: 'Reset Password',
                color: const Color(0xff20402A),
                iconcolor: const Color(0xff1B4332),
              ),
              SizedBox(height: 177.h),
              TextFormFieldWidget(
                onChanged: (v) {
                  setState(() {});
                },
                textEditingController: emailController,
                text: "Enter your registered Email",
                width: 319.w,
                align: TextAlign.center,
                validator: (value) {
                  bool isValidEmail = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                      .hasMatch(value!);
                  if (value.isEmpty) return "Please enter Email";
                  if (!isValidEmail) return "Please enter valid Email";
                  return null;
                },
                Fontsize: 16.sp,
              ),
              SizedBox(height: 49.h),
              CustomButtons(
                borderRadius: 7.78.r,
                width: 119.w,
                height: 36.27.h,
                onPressed: isLoading
                    ? null
                    : () {
                        if (formKey.currentState!.validate()) {
                          resetPassword(context);
                        }
                      },
                backcolor: emailController.text.isNotEmpty
                    ? const Color(0xff1B4332)
                    : Colors.grey,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white, strokeWidth: 2)
                    : ButtonText(
                        color: const Color(0xffFBFBF0),
                        text: 'Proceed',
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
