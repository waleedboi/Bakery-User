import 'package:completefoodorderingappui/homescreenlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassResetSuccessScreen extends StatefulWidget {
  const PassResetSuccessScreen({super.key});

  @override
  State<PassResetSuccessScreen> createState() => _PassResetSuccessScreenState();
}

class _PassResetSuccessScreenState extends State<PassResetSuccessScreen> {
  @override
   void initState(
  ){
     Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreenListScreen() ));
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
              height: 100.h,
            ),
            Image(image: AssetImage("images/Group 14055.png")),
            SizedBox(
              height: 56.h,
            ),
            Text(
              "Password Reset\n Successful",
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