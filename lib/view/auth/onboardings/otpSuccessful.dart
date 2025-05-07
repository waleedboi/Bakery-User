import 'package:completefoodorderingappui/view/auth/onboardings/signin.dart';
import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpSuccessScreen extends StatefulWidget {
  const OtpSuccessScreen({super.key});

  @override

  State<OtpSuccessScreen> createState() => _OtpSuccessScreenState();
}

class _OtpSuccessScreenState extends State<OtpSuccessScreen> {
  @override
  void initState(
  ){
     Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SignInScreen() ));
    });

    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: Color(0xffEEEEE6),
        child: Column(
          children: [
            SizedBox(
              height: 55.h,
            ),
            AppBarClass(
              text: 'Profile', color: Color(0xff20402A), iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 60.h,
            ),
            Image(image: AssetImage("images/Group 14055.png")),
            SizedBox(
              height: 56.h,
            ),
            Text(
              "OTP Verification \n Successful",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Color(0xff20402A),
              ),
            ),
            SizedBox(
              height: 187.h,
            ),
            Text(
              "Redirecting you to the app wall ...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xff20402A),
              ),
            ),
          ],
        ),
      ),
   
   
    );
  }
}
