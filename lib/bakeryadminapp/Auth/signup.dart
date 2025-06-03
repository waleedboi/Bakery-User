import 'package:completefoodorderingappui/bakeryadminapp/Auth/signin.dart';
import 'package:completefoodorderingappui/bakeryadminapp/register_bakery/register_bakery.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSignUpScreen extends StatefulWidget {
  const AdminSignUpScreen({super.key});

  @override
  State<AdminSignUpScreen> createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  Future<void> registerUser() async {
    setState(() => _isLoading = true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );

      String? token = await FirebaseMessaging.instance.getToken();

      await FirebaseFirestore.instance
          .collection('admins')
          .doc(credential.user!.uid)
          .set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'uid': credential.user!.uid,
        'createdAt': Timestamp.now(),
        'tokens': token != null ? [token] : [],
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const RegisterBakery()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
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
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                MediaQuery.of(context).padding.top,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                          alignment: Alignment.center,
                          child: Text("Signup To Register Your Bakery!",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.5)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                const Text("Name"),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration()),
                const SizedBox(height: 20),
                const Text("Email"),
                const SizedBox(height: 8),
                TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration()),
                const SizedBox(height: 20),
                const Text("Password"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passController,
                  obscureText: _obscurePassword,
                  decoration: _inputDecoration().copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : registerUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 14),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Register",
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
                            builder: (_) => const AdminSignInScreen())),
                    child: const Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        children: [
                          TextSpan(
                              text: "Click here",
                              style: TextStyle(color: Colors.blue)),
                          TextSpan(text: " to login"),
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
        filled: true, fillColor: Colors.white, border: InputBorder.none);
  }
}