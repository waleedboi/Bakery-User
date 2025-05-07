import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget noBakery() {
  return Align(
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.4),
          ),
          child: Container(
            width: 125,
            height: 125,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image:
                    DecorationImage(image: AssetImage('images/favbakery.png'))),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Oops! You don’t have a\nfavourite store yet 😥",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff20402A),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            "Click on the heart of your favourite stores to access them in one click and receive notifications for each new basket published!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
