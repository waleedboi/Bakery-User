import 'package:completefoodorderingappui/view/auth/onboardings/SignIn.dart';
import 'package:completefoodorderingappui/view/auth/onboardings/otpVeification.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  bool _hasAlphabet = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();

    _passController.addListener(_validatePassword);
  }

  @override
  void dispose() {
    _passController.removeListener(_validatePassword);
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    final password = _passController.text;

    setState(() {
      _hasAlphabet = RegExp(r'[a-zA-Z]').hasMatch(password);

      _hasNumber = RegExp(r'[0-9]').hasMatch(password);

      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

  bool get _isPasswordStrong =>
      _hasAlphabet &&
      _hasNumber &&
      _hasSpecialChar &&
      _passController.text.length >= 8;

  Future<void> registerUser() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    if (!_isPasswordStrong) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please create a strong password with all requirements')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passController.text.trim(),
      );
      String? token = await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'uid': credential.user!.uid,
        'createdAt': Timestamp.now(),
        'tokens': token != null ? [token] : [],
        'otpVerified': false,
      });

      bool otpSent =
          await EmailOTP.sendOTP(email: _emailController.text.trim());
      if (!otpSent) {
        throw Exception("Failed to send OTP. Check your SMTP settings.");
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OTPVerificationWidget(
            isresetpassword: false,
            id: credential.user!.uid,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.center,
                          child: Text("Signup",
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
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                              controller: _nameController,
                              decoration: _inputDecoration()),
                        ),
                        const SizedBox(height: 20),
                        const Text("Email"),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                              controller: _emailController,
                              decoration: _inputDecoration()),
                        ),
                        const SizedBox(height: 20),
                        const Text("Password"),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: TextFormField(
                            controller: _passController,
                            obscureText: _obscurePassword,
                            decoration: _inputDecoration().copyWith(
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Password Requirements:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildPasswordRequirement(
                                '• Alphabet',
                                _hasAlphabet,
                              ),
                              const SizedBox(height: 4),
                              _buildPasswordRequirement(
                                '• Number',
                                _hasNumber,
                              ),
                              const SizedBox(height: 4),
                              _buildPasswordRequirement(
                                '• Special Character',
                                _hasSpecialChar,
                              ),
                              const SizedBox(height: 4),
                              _buildPasswordRequirement(
                                '• Minimum 8 characters',
                                _passController.text.length >= 8,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: (_isLoading || !_isPasswordStrong)
                                ? null
                                : registerUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isPasswordStrong
                                  ? const Color.fromARGB(255, 46, 125, 50)
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 14),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
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
                                    builder: (_) => const SignInScreen())),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildPasswordRequirement(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          isValid ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isValid ? Colors.green : Colors.red,
          size: 16,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? Colors.green : Colors.red,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration() {
    return const InputDecoration(border: InputBorder.none);
  }
}
