import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/modelclasshome.dart';
import 'package:completefoodorderingappui/restaurantmenu.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class QuantitySelectedScreen extends StatefulWidget {
  // Modelclass model;
  DealsModel model;
  QuantitySelectedScreen({
    super.key,
    required this.model,
  });

  @override
  State<QuantitySelectedScreen> createState() => _QuantitySelectedScreenState();
}

class _QuantitySelectedScreenState extends State<QuantitySelectedScreen> {
  @override
  int index = 0;
  int counter = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffEEEEE6),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: Column(
          children: [
            Container(
              height: 242.h,
              width: 375.w,
              decoration: BoxDecoration(
                color: Color(0xffEEEEE6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(11.r),
                  topRight: Radius.circular(11.r),
                ),
                // image: DecorationImage(
                //   image: AssetImage("images/restaurantpage.png"),
                //   fit: BoxFit.cover,
                // ),
              ),
              child: Stack(
                children: [
                  PageView.builder(
                    onPageChanged: (value) {
                      index = value;
                      setState(() {});
                      print("${value}");
                    },
                    itemCount: widget.model.image!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 242.h,
                          width: 375.w,
                          decoration: BoxDecoration(
                            color: Color(0xffEEEEE6),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(11.r),
                              topRight: Radius.circular(11.r),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                widget.model.image![index],
                              ),
                            ),
                          ));
                    },
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 16.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(
                                      () => (RestaurantMenuScreen(
                                            model: Modelclass.thirdListView[0],
                                          )),
                                      transition: Transition.rightToLeft);
                                },
                                child: Container(
                                  height: 35.h,
                                  width: 95.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xff9E8B78).withOpacity(0.8),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 17.26.w,
                                      ),
                                      SizedBox(
                                        width: 11.h,
                                      ),
                                      Text(
                                        "Back",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.26.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                height: 30.h,
                                width: 72.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff20402A),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Bakery",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.23.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 216.w,
                          ),
                          Column(
                            children: [
                              Container(
                                height: 32.h,
                                width: 32.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff383736).withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image(
                                    image: AssetImage("images/2xheart.png"),
                                    height: 16.59.h,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 13.h,
                              ),
                              Container(
                                height: 32.h,
                                width: 32.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff383736).withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Image(
                                    image: AssetImage("images/2xnotif.png"),
                                    height: 20.15.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 22,
                            width: 54.83.w,
                          ),
                          Container(
                            height: 17.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Row(
                                children: List.generate(
                                  widget.model.image!.length,
                                  (i) =>
                                      // {
                                      //   return Cot
                                      // }

                                      Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2.w),
                                    child: Container(
                                      height: index == i ? 9.w : 7.w,
                                      width: index == i ? 9.w : 7.w,
                                      decoration: BoxDecoration(
                                        color: index == i
                                            ? Colors.white
                                            : const Color.fromARGB(
                                                    255, 211, 209, 209)
                                                .withOpacity(0.6),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 24.67.h,
                            width: 54.83.w,
                            decoration: BoxDecoration(
                              color: Color(0xffFFC107),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 9.w,
                                ),
                                Image(image: AssetImage("images/Star 1.png")),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "5.0",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.21.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 18.h,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Text(
                  widget.model.title!,
                  style: TextStyle(
                    color: Color(0xff20402A),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.48.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 14.h,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                ),
                child: Text(
                  widget.model.description!,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                    fontSize: 11.9.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 21.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 18.w,
                ),
                Image(
                  image: AssetImage("images/building-store 1.png"),
                  height: 15.75.h,
                ),
                SizedBox(
                  width: 18.w,
                ),
                Text(
                  widget.model.bakeryname!,
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
                  width: 18.w,
                ),
                Image(
                  image: AssetImage("images/clock 1.png"),
                  height: 16.09.h,
                ),
                SizedBox(
                  width: 18.w,
                ),
                Row(
                  children: [
                    Text(
                      " Pickup Between : ${widget.model.pickupbetween!}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.65.sp,
                      ),
                    ),
                    Text(
                      " 09:00-16:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.65.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 38.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (counter > 0) {
                       counter-=1;
                      setState(() {});
                    }
                   

                  },
                  child: Container(
                    height: 27.h,
                    width: 27.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                        shape: BoxShape.circle),
                    child: Center(
                      child: Container(
                        height: 2.h,
                        width: 9.w,
                        color: Color(0xff20402A),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 18.w,
                ),
                Container(
                  height: 48.h,
                  width: 96.w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Center(
                    child: Text(
                      // counter .toString(), 1st way
                      "${counter}", // 2nd
                      style: TextStyle(
                        fontSize: 28.1.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 18.w,
                ),
                InkWell(
                  onTap: () {
                    counter = counter + 1;
                    setState(() {});
                  },
                  child: Container(
                    height: 27.h,
                    width: 27.w,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                        shape: BoxShape.circle),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      color: Color(0xff20402A),
                      size: 19.w,
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 38.h,
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
              height: 34.h,
            ),
            CustomButtons(
                onPressed: () {
                  // Get.to(QuantitySelectedScreen(
                  //           model: widget.thirdListView![index],
                  //             ));
                },
                borderRadius: 7.78.r,
                child: ButtonText(
                  color: Color(0xffFBFBF0),
                  text: 'Add to Cart',
                  Font: FontWeight.w500,
                  fontsize: 14.sp,
                ),
                width: 298.w,
                height: 42.h,
                backcolor: ButtonsColors.secondaryColor),
          ],
        ),
      ),
    );
  }
}
