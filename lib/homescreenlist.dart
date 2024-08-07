import 'package:completefoodorderingappui/buttons.dart';
import 'package:completefoodorderingappui/createAnAccount.dart';
import 'package:completefoodorderingappui/modelclasshome.dart';
import 'package:completefoodorderingappui/restaurantmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomeScreenListScreen extends StatefulWidget {
  const HomeScreenListScreen({super.key});

  @override
  State<HomeScreenListScreen> createState() => _HomeScreenListScreenState();
}

class _HomeScreenListScreenState extends State<HomeScreenListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  String searchQuerry = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: Color(0xffEEEEE6),
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 44.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image(image: AssetImage("images/Group 13405.png")),
                CustomButtons(
                    borderRadius: 100.r,
                    child: ButtonText(
                      color: Colors.white,
                      text: 'Store List',
                      Font: FontWeight.w400,
                      fontsize: 12.34.sp,
                    ),
                    width: 136.67.w,
                    height: 36.54.h,
                    onPressed: () {},
                    backcolor: Color(0xff20402A)),
                CustomButtons(
                    borderRadius: 100.r,
                    child: ButtonText(
                      color: Color(0xff20402A),
                      text: 'See on Map',
                      Font: FontWeight.w400,
                      fontsize: 12.34.sp,
                    ),
                    width: 136.67.w,
                    height: 36.54.h,
                    onPressed: () {},
                    backcolor: Colors.white),
              ],
            ),
            SizedBox(
              height: 23.h,
            ),
            Container(
              width: 335.w,
              height: 53.h,
              child: TextFormField(
                controller: searchcontroller,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 17.0, horizontal: 10.0),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Image(image: AssetImage("images/Layer 2.png")),
                  suffixIcon: Image(image: AssetImage("images/Vector.png")),
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color(0xff4B4B4B),
                    fontSize: 14.sp,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.r),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 202, 202, 202)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.r),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 202, 202, 202)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 23.w,
                ),
                Text(
                  "New on Takkul",
                  style: TextStyle(
                    color: Color(0xff20402A),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9.h,
            ),
            Container(
              height: 245.h,
              width: ScreenUtil().screenWidth,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: Modelclass.thirdListView.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(
                          () => RestaurantMenuScreen(
                                model: Modelclass.thirdListView[index],
                              ),
                          transition: Transition.leftToRight);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 23.w,
                        ),
                        Card(
                          elevation: 0,
                          child: Container(
                            height: 245.h,
                            width: 283.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(11.r),
                                topRight: Radius.circular(11.r),
                              ),
                            ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 157.h,
                                      width: 283.w,
                                      decoration: BoxDecoration(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(11.r),
                                          topRight: Radius.circular(11.r),
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            Modelclass.thirdListView[index]
                                                .listofimages![0],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 9.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Container(
                                                    height: 26.h,
                                                    width: 95.w,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff383736)
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Modelclass
                                                            .thirdListView[
                                                                index]
                                                            .firstHeading!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 11.83.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 135.w,
                                                  ),
                                                  Container(
                                                    height: 27.h,
                                                    width: 27.w,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff383736)
                                                          .withOpacity(0.8),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Image(
                                                        image: AssetImage(
                                                            "images/heart.png")),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 9.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Container(
                                                    height: 24.18.h,
                                                    width: 65.95.w,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xff20402A),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(20),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        Modelclass
                                                            .thirdListView[
                                                                index]
                                                            .secondHeading!,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 11.83.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 50.h,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Text(
                                                    Modelclass
                                                        .thirdListView[index]
                                                        .thirdHeading!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.17.sp,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Expanded(
                                      child: Container(
                                    color: Colors.white,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "images/2xtime.png"),
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              Modelclass
                                                  .thirdListView[index].time!,
                                              style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 5, 4, 4),
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 105.w,
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
                                                  Image(
                                                      image: AssetImage(
                                                          "images/Star 1.png")),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Text(
                                                    "${Modelclass.thirdListView[index].rating!}   ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12.21.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  "images/loc2x.png"),
                                              height: 22.h,
                                            ),
                                            SizedBox(
                                              width: 8.w,
                                            ),
                                            Text(
                                              Modelclass.thirdListView[index]
                                                  .location!,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 17.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 23.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Around You",
                  style: TextStyle(
                    color: Color(0xff20402A),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 9.h,
            // ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: Modelclass.thirdListView.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    SizedBox(
                      width: 23.w,
                    ),
                    Card(
                      elevation: 0,
                      child: Container(
                        height: 237.h,
                        width: 338.w,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11.r),
                            topRight: Radius.circular(11.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 157.h,
                                  width: 338.w,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(11.r),
                                      topRight: Radius.circular(11.r),
                                    ),
                                    image: DecorationImage(
                                      image: AssetImage(
                                        Modelclass.thirdListView[index]
                                            .listofimages![0],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 9.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Container(
                                                height: 26.h,
                                                width: 95.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff383736)
                                                      .withOpacity(0.8),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    Modelclass
                                                        .thirdListView[index]
                                                        .firstHeading!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11.83.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 189.w,
                                              ),
                                              Container(
                                                height: 27.h,
                                                width: 27.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff383736)
                                                      .withOpacity(0.8),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Image(
                                                    image: AssetImage(
                                                        "images/heart.png")),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 9.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Container(
                                                height: 24.18.h,
                                                width: 65.95.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff20402A),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    Modelclass
                                                        .thirdListView[index]
                                                        .secondHeading!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 11.83.sp,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 50.h,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Text(
                                                Modelclass.thirdListView[index]
                                                    .thirdHeading!,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.17.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                height: 200.h,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Image(
                                          image:
                                              AssetImage("images/2xtime.png"),
                                          height: 22.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          Modelclass.thirdListView[index].time!,
                                          style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 5, 4, 4),
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 155.w,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Container(
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
                                                Image(
                                                    image: AssetImage(
                                                        "images/Star 1.png")),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  "${Modelclass.thirdListView[index].rating!}   ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12.21.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image(
                                          image: AssetImage("images/loc2x.png"),
                                          height: 22.h,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Text(
                                          Modelclass
                                              .thirdListView[index].location!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
