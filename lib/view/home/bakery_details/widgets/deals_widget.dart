import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dealsWidget() {
  return Container(
    height: 45,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.withOpacity(0.2)),
    child: Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Deals",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
