import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppColors {
  static Color primaryColor = const Color(0xff1B4332);
}

class ButtonsColors {
  static Color secondaryColor = const Color(0xff20402A);
}

class TextFormFieldWidget extends StatelessWidget {
  TextFormFieldWidget({
    super.key,
    required this.textEditingController,
    required this.text,
    required this.validator,
    required this.onChanged,
    required this.width,
    this.obscureText = false,
    this.suffixicon,
    this.obscuringCharacter = "*",
    required this.align,
  });

  final TextEditingController textEditingController;
  String text;
  double width;
  Widget? suffixicon;
  void Function(String) onChanged;
  bool obscureText;
  String obscuringCharacter;
  String? Function(String?) validator;
  TextAlign align;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          textAlign: align,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 13.h,
        ),
        SizedBox(
          width: width,
          child: TextFormField(
            controller: textEditingController,
            style: const TextStyle(
              color: Colors.black,
            ),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              suffixIcon: suffixicon,
              contentPadding: EdgeInsets.only(
                bottom: 5.h,
                left: 5.w,
              ),
              fillColor: Colors.white,
              filled: true,
              // errorStyle: TextStyle(
              //   color: Colors.transparent,
              //   fontSize: 0,
              // ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: BorderSide(
                      color: const Color(0xff20402A).withOpacity(0.16))),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.r),
                borderSide: const BorderSide(color: Color(0xff20402A)),
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  )),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                  )),
              border: InputBorder.none,
            ),
            obscureText: obscureText,
            obscuringCharacter: obscuringCharacter,
            validator: validator,
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}

class AppBarClass extends StatelessWidget {
  AppBarClass({
    super.key,
    required this.text,
    required this.color,
    required this.iconcolor,
  });
  String text;
  Color color;
  Color iconcolor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 15.w,
        ),
        IconButton(
          onPressed: () {
            // Navigator.pop(context);
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: iconcolor,
          ),
        ),
        SizedBox(
          width: 17.w,
        ),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 17.26.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
