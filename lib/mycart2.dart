import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCartScreenSecond extends StatefulWidget {
  const MyCartScreenSecond({super.key});

  @override
  State<MyCartScreenSecond> createState() => _MyCartScreenSecondState();
}

class _MyCartScreenSecondState extends State<MyCartScreenSecond> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Container(
          height: 130.h,
          width: 387.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 297.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quantity Selected :",
                      style: TextStyle(
                          fontSize: 13.65.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "02",
                      style: TextStyle(
                          fontSize: 13.65.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 297.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price :",
                      style: TextStyle(
                          fontSize: 13.65.sp, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "AED 108",
                      style: TextStyle(
                          fontSize: 13.65.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 297.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Discount (Coupon) :",
                      style: TextStyle(
                          fontSize: 13.65.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF0000)),
                    ),
                    Text(
                      "AED 22",
                      style: TextStyle(
                          fontSize: 13.65.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFF0000)),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              CustomButtons(
                  onPressed: () {},
                  borderRadius: 8.r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonText(
                        color: Color(0xffFFFFFF),
                        text: 'Net Pay : AED 86',
                        Font: FontWeight.w500,
                        fontsize: 14.sp,
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  width: 306.04.w,
                  height: 42.h,
                  backcolor: Color(0xff292929)),
            ],
          ),
        ),
      ),
      body: Container(
        color: Color(0xffEEEEE6),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            SizedBox(
              height: 59.h,
            ),
            AppBarClass(
              text: 'My Cart',
              color: Color(0xff20402A),
              iconcolor: Color(0xff1B4332),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 31.w,
                ),
                Image(
                  image: AssetImage("images/building-store 1.png"),
                  height: 21.h,
                ),
                SizedBox(
                  width: 18.w,
                ),
                Text(
                  "The Bakery LLC & Cake Shop",
                  // Modelclass.thirdListView.deals[DealsModel].bakeryname!,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.65.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 31.w,
                ),
                Image(
                  image: AssetImage("images/geo-alt 1.png"),
                  height: 21.h,
                ),
                SizedBox(
                  width: 18.w,
                ),
                Text(
                  "25 m - Al Barsha 1, Al Rabwah, Shop No. 11",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.65.sp,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Card(
              elevation: 1,
              child: Container(
                height: 74.h,
                width: 311.w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.92.r)),
                child: Row(
                  children: [
                    Container(
                      height: 39.h,
                      width: 57.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/Rectangle 94 (1).png")),
                          borderRadius: BorderRadius.circular(3.52.r)),
                    ),
                    SizedBox(
                      width: 14.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Salade",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(
                              width: 133.w,
                            ),
                            Image(
                              image: AssetImage("images/Group 14034 (1).png"),
                              height: 10.5.h,
                              width: 9.33.w,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              "X 2",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 11.25.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          children: [
                            Image(
                              image: AssetImage("images/clock 1.png"),
                              height: 13.65.h,
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              "Today between 15:30 and 16:00",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 11.25.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              width: 310.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Method",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  Container(
                    width: 105.w,
                    height: 15.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.add,
                          size: 16.w,
                        ),
                        Text(
                          "Add New Card",
                          style: TextStyle(
                            color: Color(0xff3E3E3E),
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                aspectRatio: 0.1,
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                // autoPlayInterval: Duration(seconds: 3),
                // autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                // onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
              items: [
                Container(
                   width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                 // color: Colors.amber,
                  child: Image(image: AssetImage("images/cardss.png"),
                  
                              
                            fit:    BoxFit.contain),
                ),
                Container(
                   width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                 // color: Colors.amber,
                  child: Image(image: AssetImage("images/cardss.png"),
                  
                              
                            fit:    BoxFit.contain),
                ),
                Container(
                   width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                 // color: Colors.amber,
                  child: Image(image: AssetImage("images/cardss.png"),
                  
                              
                            fit:    BoxFit.contain),
                ),
                
               
              ],

              //  [1, 2, 3, 4, 5].map((i) {
              //   return Builder(
              //     builder: (BuildContext context) {
              //       return Container(
              //           width: MediaQuery.of(context).size.width,
              //           margin: EdgeInsets.symmetric(horizontal: 5.0),
              //           decoration: BoxDecoration(color: Colors.amber),
              //           child: Text(
              //             'text $i',
              //             style: TextStyle(fontSize: 16.0),
              //           ));
              //     },
              //   );
              // }).toList(),
            ),
            SizedBox(
              height: 21.h,
            ),
            CustomButtons(
                onPressed: () {
                  Get.to(() => MyCartScreenSecond(),
                      transition: Transition.leftToRight);
                },
                borderRadius: 8.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage("images/Vector (2).png"),
                      height: 20.h,
                      width: 17.w,
                    ),
                    SizedBox(width: 5.w),
                    ButtonText(
                      color: Color(0xffFFFFFF),
                      text: 'Pay',
                      Font: FontWeight.w500,
                      fontsize: 14.sp,
                    ),
                  ],
                ),
                width: 306.04.w,
                height: 50.04.h,
                backcolor: Color(0xff292929)),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }
}
