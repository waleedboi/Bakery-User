import 'package:completefoodorderingappui/clipper.dart';
import 'package:completefoodorderingappui/splashscreen2.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState(
  ){
     Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SplashScreen2() ));
    });

    super.initState();
  }
  
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: ScreenUtil().screenHeight,
              width: ScreenUtil().screenWidth,
              color: Color(0xffDE5B33),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      height: 150.66.h,
                      width: 94.98.h,
                      child: Image(image: AssetImage("images/g14.png")),
                    ),
                  ),
                  ClipPath(
                    clipper: TopClipper(),
                    child: Container(
                      height: 150.h,
                      width: 375.w,
                      color: AppColors.primaryColor ,
                      child: Stack(children: [
                        Container(
                          height: 44.h,
                          width: 375.w,
                          child: Row(
                            
                            children: [
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                
                                "9:41",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11.09.h,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 275.w,),
                              Row(
                                children: 
                               
                                [
                                  Container(
                                    height: 10.67.h,
                                    width: 17.w,
                                    child: Image(image: AssetImage("images/Mobile Signal.png",
                                    ),
                                    ),
                                  ),
                                  SizedBox(width: 2.w,),
                                  Container(
                                    height: 10.97.h,
                                    width: 17.w,
                                    child: Image(image: AssetImage("images/Wifi.png",
                                    ),
                                    ),
                                  ),
                                 SizedBox(width: 2.w,),
                                  Container(
                                    height: 11.33.h,
                                    width: 24.33.w,
                                    child: Image(image: AssetImage("images/Battery.png",
                                    ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ]),
                    ),
                 
                 
                  ),
                ],
              )),
        ],
      ),
   
   
    );
  }
}
