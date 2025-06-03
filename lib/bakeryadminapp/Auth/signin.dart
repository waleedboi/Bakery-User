import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/bakeryadminapp/Auth/admin_forget_password.dart';
import 'package:completefoodorderingappui/bakeryadminapp/Auth/signup.dart';
import 'package:completefoodorderingappui/bakeryadminapp/admin_bottom_bar/admin_bottom_bar.dart';
import 'package:completefoodorderingappui/bakeryadminapp/register_bakery/register_bakery.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({super.key});

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> loginUser() async {
    setState(() => _isLoading = true);
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );

      final uid = userCredential.user!.uid;
      final token = await FirebaseMessaging.instance.getToken();

      final docSnapshot =
          await FirebaseFirestore.instance.collection('admins').doc(uid).get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final bakeryName = data?['bakeryName'];

        // Add token to Firestore
        if (token != null) {
          await FirebaseFirestore.instance
              .collection('admins')
              .doc(uid)
              .update({
            'tokens': FieldValue.arrayUnion([token]),
          });
        }
        if (bakeryName != null && bakeryName.toString().isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminBottomBarScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const RegisterBakery()),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin data not found')),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Align(
                          alignment: Alignment.center,
                          child: Text("Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      const Text("Email"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        decoration: _inputDecoration(),
                      ),
                      const SizedBox(height: 20),
                      const Text("Password"),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passController,
                        obscureText: _obscurePassword,
                        decoration: _inputDecoration().copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AdminForgotPasswordScreen()),
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forget your password?",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 14),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text("Proceed",
                                  style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AdminSignUpScreen()),
                          ),
                          child: const Text.rich(
                            TextSpan(
                              text: "Didn't have any accounts? ",
                              children: [
                                TextSpan(
                                    text: "Click here",
                                    style: TextStyle(color: Colors.blue)),
                                TextSpan(text: " to create new"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(
      filled: true,
      fillColor: Colors.white,
      border: InputBorder.none,
    );
  }
}
