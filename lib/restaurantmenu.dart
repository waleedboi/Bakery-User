import 'package:completefoodorderingappui/homescreenlist.dart';
import 'package:completefoodorderingappui/modelclasshome.dart';
import 'package:completefoodorderingappui/quantitySelected.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RestaurantMenuScreen extends StatefulWidget {
  Modelclass model;
  RestaurantMenuScreen({
    super.key,
    required this.model,
  });

  @override
  State<RestaurantMenuScreen> createState() => _RestaurantMenuScreenState();
}

class _RestaurantMenuScreenState extends State<RestaurantMenuScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xffEEEEE6),
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        child: SingleChildScrollView(
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
                      itemCount: widget.model.listofimages!.length,
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
                                  widget.model.listofimages![index],
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
                                    Get.to(() => HomeScreenListScreen(),
                                        transition: Transition.leftToRight);
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
                                    widget.model.listofimages!.length,
                                    (i) =>
                                        // {
                                        //   return Cot
                                        // }

                                        Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Container(
                                        height: index==i ? 9.w: 7.w,
                                        width: index==i ? 9.w: 7.w,
                                        decoration: BoxDecoration(
                                          color: index == i
                                              ?  Colors.white
                                              : const Color.fromARGB(255, 211, 209, 209).withOpacity(0.6),
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
                    "The Bakery LLC & Cake Shop",
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
                    "One of the best finest Bakery Shop in Dubai.",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.65.sp,
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
                    image: AssetImage("images/clock 1.png"),
                    height: 13.65.h,
                  ),
                  SizedBox(
                    width: 18.w,
                  ),
                  Row(
                    children: [
                      Text(
                        "Pickup Time : ",
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
                height: 10.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 18.w,
                  ),
                  Image(
                    image: AssetImage("images/geo-alt 1.png"),
                    height: 15.75.h,
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
                height: 23.h,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18,
                  ),
                  child: Container(
                    height: 42.h,
                    width: 326.w,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18.r)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8, left: 9),
                      child: Text(
                        "Deals",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.61.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 340.w,
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: widget.model.deals!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: InkWell(
                        onTap: () {
                          Get.to(QuantitySelectedScreen(
                            model: widget.model.deals![index],
                          ));
                        },
                        child: Container(
                          height: 113.h,
                          width: 334.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: Color(0xffFFC107),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 21),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.model.deals![index].title!,
                                            style: TextStyle(
                                              color: Color(0xff20402A),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          Text(
                                            widget.model.deals![index]
                                                .description!,
                                            style: TextStyle(
                                              color: Color(0xff20402A),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.9.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Stack(
                                        children: [
                                          Container(
                                            height: 69.h,
                                            width: 94.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4.12.r),
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                  widget.model.deals![index]
                                                      .image![0],
                                                ))),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Container(
                                              height: 21.h,
                                              width: 82.w,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(
                                                            12.99.r),
                                                    topRight: Radius.circular(
                                                        12.99.r),
                                                  )),
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                          "images/paper-bag 1 (1).png",
                                                        ),
                                                        height: 13.18.h,
                                                        width: 13.18.w,
                                                      ),
                                                      Text(
                                                        "Only ${widget.model.deals![index].noofitems!} left  ",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 11.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Stack(
                                        children: [
                                          Text(
                                            "AED ${widget.model.deals![index].pricing!}",
                                            style: TextStyle(
                                              color: Color(0xffDE5B33),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.69.sp,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: Container(
                                              height: 2.h,
                                              width: 50.w,
                                              color: Color(0xffDE5B33),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      "AED ${widget.model.deals![index].priceafterdiscount!}",
                                      style: TextStyle(
                                        color: Color(0xff20402A),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 145.w,
                                    ),
                                    Text(
                                      "${widget.model.deals![index].discount!}% OFF",
                                      style: TextStyle(
                                        color: Color(0xffD49F00),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
