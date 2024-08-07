
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       SizedBox(height: 91.h,),
        Container(
          child: Image(
            image: AssetImage(
              "images/Group 14053.png",
            ),
            height: 188.h,
            width: 192.w,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Text(
          "Save Food",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.h,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        Text(
          "Explore a world of fresh food\noptions with Takkul",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff4A4A47),
            fontSize: 14.h,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
