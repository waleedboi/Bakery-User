import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsandConditionScreen extends StatefulWidget {
  const TermsandConditionScreen({super.key});

  @override
  State<TermsandConditionScreen> createState() => _TermsandConditionScreenState();
}

class _TermsandConditionScreenState extends State<TermsandConditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
         height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: Color(0xffEEEEE6),
        child: Column(children: [
           SizedBox(
              height: 55.h,
            ),
            AppBarClass(
              text: 'Terms & Conditions',
              color: Color(0xff20402A),
              iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              width: 319.w,
              height: 577.h,
              child: SingleChildScrollView(
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla venenatis neque dapibus elit vestibulum interdum. Ut rutrum eros et quam mollis volutpat sit amet nec sem. Aliquam elit massa, ultrices ut orci id, consectetur vulputate mauris. Suspendisse aliquam bibendum lorem non sodales. \n\nPraesent non ultrices felis, et blandit dolor. Integer posuere varius condimentum. Vivamus ullamcorper nisl et velit semper, et euismod felis porttitor. Pellentesque id nulla vel lorem scelerisque ultricies. Nullam ultricies egestas ex in congue. \n\nQuisque quis sapien sagittis, semper libero id, vulputate tortor. Suspendisse placerat tempor aliquet. In vitae tellus finibus, convallis est sit amet, elementum ipsum. Ut fermentum mauris non lobortis lacinia.  \n\nMorbi venenatis justo nulla, sit amet loborti mi dapibus sed. Nunc vel libero sit amet magna pulvinar facilisis.Praesent at libero quam. Fusce pretium iaculis se Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla venenatis neque dapibus elit vestibulum interdum. Ut rutrum eros et quam mollis volutpat sit amet nec sem. Aliquam elit massa, ultrices ut orci id, consectetur vulputate mauris. Suspendisse aliquam bibendum lorem non sodales. Praesent non ultrices felis, et blandit dolor. Integer posuere varius condimentum. Vivamus ullamcorper nisl et velit semper, et euismod felis porttitor. Pellentesque id nulla vel lorem scelerisque ultricies. Nullam ultricies egestas ex in congue. Quisque quis sapien sagittis, semper libero id, vulputate tortor. Suspendisse placerat tempor aliquet. In vitae tellus finibus, convallis est sit amet, elementum ipsum. Ut fermentum mauris non lobortis lacinia. Morbi venenatis justo nulla, sit amet lobortis mi dapibus sed. Nunc vel libero sit amet magna pulvinar facilisis.Praesent at libero quam. Fusce pretium iaculis se",
              
              textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 14.sp),),
                         
              ),
            )
        ],),
      ),
 
    );
  }
}