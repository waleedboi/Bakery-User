import 'package:completefoodorderingappui/view/home/homescreens/quantitySelected.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:completefoodorderingappui/models/modelclasshome.dart';
import 'package:completefoodorderingappui/view/home/homescreens/restaurantmenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreenListScreen extends StatefulWidget {
  const HomeScreenListScreen({
    super.key,
  });

  @override
  State<HomeScreenListScreen> createState() => _HomeScreenListScreenState();
}

class _HomeScreenListScreenState extends State<HomeScreenListScreen> {
  TextEditingController searchcontroller = TextEditingController();
  String searchQuerry = '';
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == 1
          ? null
          : AppBar(
              toolbarHeight: 100,
              backgroundColor: Color(0xffEEEEE6),
              actions: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image: AssetImage("images/Group 13405.png")),
                      CustomButtons(
                        borderRadius: 100.r,
                        child: ButtonText(
                          color: index == 0 ? Colors.white : Color(0xff20402A),
                          text: 'Store List',
                          Font: FontWeight.w400,
                          fontsize: 12.34.sp,
                        ),
                        width: 136.67.w,
                        height: 36.54.h,
                        onPressed: () {
                          index = 0;
                          setState(() {});
                        },
                        backcolor:
                            index == 0 ? Color(0xff20402A) : Colors.white,
                      ),
                      CustomButtons(
                        borderRadius: 100.r,
                        child: ButtonText(
                          color: index == 0 ? Color(0xff20402A) : Colors.white,
                          text: 'See on Map',
                          Font: FontWeight.w400,
                          fontsize: 12.34.sp,
                        ),
                        width: 136.67.w,
                        height: 36.54.h,
                        onPressed: () {
                          index = 1;
                          setState(() {});
                        },
                        backcolor:
                            index == 0 ? Colors.white : Color(0xff20402A),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      body: Stack(
        children: [
          Column(children: [
            index == 0
                ? Expanded(
                    child: Container(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      color: Color(0xffEEEEE6),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            child: Column(
                              children: [
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                      hintText: "Search",
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Image(
                                          image:
                                              AssetImage("images/Layer 2.png")),
                                      suffixIcon: Image(
                                          image:
                                              AssetImage("images/Vector.png")),
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        color: Color(0xff4B4B4B),
                                        fontSize: 14.sp,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 202, 202, 202)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                        borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 202, 202, 202)),
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
                                                    model: Modelclass
                                                        .thirdListView[index],
                                                  ),
                                              transition:
                                                  Transition.leftToRight);
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(11.r),
                                                    topRight:
                                                        Radius.circular(11.r),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 157.h,
                                                          width: 283.w,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      11.r),
                                                              topRight: Radius
                                                                  .circular(
                                                                      11.r),
                                                            ),
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                Modelclass
                                                                    .thirdListView[
                                                                        index]
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
                                                                        width:
                                                                            12.w,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            26.h,
                                                                        width:
                                                                            95.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xff383736).withOpacity(0.8),
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(20),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            Modelclass.thirdListView[index].firstHeading!,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 11.83.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            135.w,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            27.h,
                                                                        width:
                                                                            27.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xff383736).withOpacity(0.8),
                                                                          shape:
                                                                              BoxShape.circle,
                                                                        ),
                                                                        child: Image(
                                                                            image:
                                                                                AssetImage("images/heart.png")),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 9.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            12.w,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            24.18.h,
                                                                        width:
                                                                            65.95.w,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xff20402A),
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(20),
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            Modelclass.thirdListView[index].secondHeading!,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 11.83.sp,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        50.h,
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            12.w,
                                                                      ),
                                                                      Text(
                                                                        Modelclass
                                                                            .thirdListView[index]
                                                                            .thirdHeading!,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              16.17.sp,
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Container(
                                                        // color: Colors.amber,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
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
                                                                      .thirdListView[
                                                                          index]
                                                                      .time!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        5,
                                                                        4,
                                                                        4),
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 105.w,
                                                                ),
                                                                Container(
                                                                  height:
                                                                      24.67.h,
                                                                  width:
                                                                      54.83.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffFFC107),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          20),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            9.w,
                                                                      ),
                                                                      Image(
                                                                          image:
                                                                              AssetImage("images/Star 1.png")),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        "${Modelclass.thirdListView[index].rating!}   ",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              12.21.sp,
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
                                                                  Modelclass
                                                                      .thirdListView[
                                                                          index]
                                                                      .location!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        13.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
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
                                Container(
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 80),
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
                                                  topLeft:
                                                      Radius.circular(11.r),
                                                  topRight:
                                                      Radius.circular(11.r),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        height: 157.h,
                                                        width: 338.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    11.r),
                                                            topRight:
                                                                Radius.circular(
                                                                    11.r),
                                                          ),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                              Modelclass
                                                                  .thirdListView[
                                                                      index]
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
                                                                      width:
                                                                          12.w,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          26.h,
                                                                      width:
                                                                          95.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(0xff383736)
                                                                            .withOpacity(0.8),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              20),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          Modelclass
                                                                              .thirdListView[index]
                                                                              .firstHeading!,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                11.83.sp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          189.w,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          27.h,
                                                                      width:
                                                                          27.w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(0xff383736)
                                                                            .withOpacity(0.8),
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image(
                                                                          image:
                                                                              AssetImage("images/heart.png")),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 9.h,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          12.w,
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          24.18
                                                                              .h,
                                                                      width:
                                                                          65.95
                                                                              .w,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Color(
                                                                            0xff20402A),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              20),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          Modelclass
                                                                              .thirdListView[index]
                                                                              .secondHeading!,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                11.83.sp,
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
                                                                      width:
                                                                          12.w,
                                                                    ),
                                                                    Text(
                                                                      Modelclass
                                                                          .thirdListView[
                                                                              index]
                                                                          .thirdHeading!,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            16.17.sp,
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
                                                  Expanded(
                                                    child: Container(
                                                      height: 200.h,
                                                      color: Colors.white,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
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
                                                                    .thirdListView[
                                                                        index]
                                                                    .time!,
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      5,
                                                                      4,
                                                                      4),
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 155.w,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            10),
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      24.67.h,
                                                                  width:
                                                                      54.83.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xffFFC107),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius.circular(
                                                                          20),
                                                                    ),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            9.w,
                                                                      ),
                                                                      Image(
                                                                          image:
                                                                              AssetImage("images/Star 1.png")),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                      Text(
                                                                        "${Modelclass.thirdListView[index].rating!}   ",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontSize:
                                                                              12.21.sp,
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
                                                                image: AssetImage(
                                                                    "images/loc2x.png"),
                                                                height: 22.h,
                                                              ),
                                                              SizedBox(
                                                                width: 8.w,
                                                              ),
                                                              Text(
                                                                Modelclass
                                                                    .thirdListView[
                                                                        index]
                                                                    .location!,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                : Expanded(
                    child: Container(
                      height: ScreenUtil().screenHeight,
                      width: ScreenUtil().screenWidth,
                      color: Color(0xffEEEEE6),
                      child: Column(children: [
                        Stack(
                          children: [
                            Container(
                                height: ScreenUtil().screenHeight,
                                width: ScreenUtil().screenWidth,
                                child: Image(
                                    image: AssetImage("images/map (1).png"))),
                            Column(
                              children: [
                                SizedBox(
                                  height: 118.h,
                                ),
                                Center(
                                  child: Container(
                                    width: 335.w,
                                    height: 53.h,
                                    child: TextFormField(
                                      controller: searchcontroller,
                                      cursorColor: Colors.grey,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 17.0,
                                                horizontal: 10.0),
                                        hintText: "Search",
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Image(
                                            image: AssetImage(
                                                "images/Layer 2.png")),
                                        suffixIcon: Image(
                                            image: AssetImage(
                                                "images/Vector.png")),
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: Color(0xff4B4B4B),
                                          fontSize: 14.sp,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          borderSide: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 202, 202, 202)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(100.r),
                                          borderSide: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 202, 202, 202)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 397.h,
                                ),
                                Container(
                                  //  width: 340.w,
                                  height: 160.h,
                                  child: ListView.builder(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    shrinkWrap: true,
                                    //  physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: Modelclass
                                        .thirdListView[0].deals!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 20.h, horizontal: 10.w),
                                        child: InkWell(
                                          onTap: () {
                                            Get.to(QuantitySelectedScreen(
                                              model: Modelclass.thirdListView[0]
                                                  .deals![index],
                                            ));
                                          },
                                          child: Container(
                                            height: 113.h,
                                            width: 334.w,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(6.r),
                                              border: Border.all(
                                                color: Color(0xffFFC107),
                                                width: 1,
                                              ),
                                            ),
                                            child: Center(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 21),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              Modelclass
                                                                  .thirdListView[
                                                                      0]
                                                                  .deals![index]
                                                                  .title!,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff20402A),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                            Text(
                                                              Modelclass
                                                                  .thirdListView[
                                                                      0]
                                                                  .deals![index]
                                                                  .description!,
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xff20402A),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize:
                                                                    11.9.sp,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Stack(
                                                          children: [
                                                            Container(
                                                              height: 69.h,
                                                              width: 94.w,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4.12.r),
                                                                      image: DecorationImage(
                                                                          image: AssetImage(
                                                                        Modelclass
                                                                            .thirdListView[0]
                                                                            .deals![index]
                                                                            .image![0],
                                                                      ))),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top: 5),
                                                              child: Container(
                                                                height: 21.h,
                                                                width: 82.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.only(
                                                                          bottomRight:
                                                                              Radius.circular(12.99.r),
                                                                          topRight:
                                                                              Radius.circular(12.99.r),
                                                                        )),
                                                                child: Stack(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Image(
                                                                          image:
                                                                              AssetImage(
                                                                            "images/paper-bag 1 (1).png",
                                                                          ),
                                                                          height:
                                                                              13.18.h,
                                                                          width:
                                                                              13.18.w,
                                                                        ),
                                                                        Text(
                                                                          "Only ${Modelclass.thirdListView[0].deals![index].noofitems!} left  ",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                11.sp,
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
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 20),
                                                        child: Stack(
                                                          children: [
                                                            Text(
                                                              "AED ${Modelclass.thirdListView[0].deals![index].pricing!}",
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xffDE5B33),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    11.69.sp,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                top: 10,
                                                              ),
                                                              child: Container(
                                                                height: 2.h,
                                                                width: 50.w,
                                                                color: Color(
                                                                    0xffDE5B33),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        "AED ${Modelclass.thirdListView[0].deals![index].priceafterdiscount!}",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xff20402A),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 13.sp,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 145.w,
                                                      ),
                                                      Text(
                                                        "${Modelclass.thirdListView[0].deals![index].discount!}% OFF",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffD49F00),
                                                          fontWeight:
                                                              FontWeight.w600,
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
                          ],
                        ),
                      ]),
                    ),
                  ),

            //              Expanded(
            //   child: Container(
            //     height: ScreenUtil().screenHeight,
            //     width: ScreenUtil().screenWidth,
            //     color: Color(0xffEEEEE6),
            //     child: Column(children: [
            //       index == 0
            //           ? Container(
            //               child: Column(
            //                 children: [
            //                   SizedBox(
            //                     height: 23.h,
            //                   ),
            //                   Container(
            //                     width: 335.w,
            //                     height: 53.h,
            //                     child: TextFormField(
            //                       controller: searchcontroller,
            //                       cursorColor: Colors.grey,
            //                       decoration: InputDecoration(
            //                         contentPadding:
            //                             const EdgeInsets.symmetric(
            //                                 vertical: 17.0, horizontal: 10.0),
            //                         hintText: "Search",
            //                         filled: true,
            //                         fillColor: Colors.white,
            //                         prefixIcon: Image(
            //                             image:
            //                                 AssetImage("images/Layer 2.png")),
            //                         suffixIcon: Image(
            //                             image:
            //                                 AssetImage("images/Vector.png")),
            //                         border: InputBorder.none,
            //                         hintStyle: TextStyle(
            //                           color: Color(0xff4B4B4B),
            //                           fontSize: 14.sp,
            //                         ),
            //                         enabledBorder: OutlineInputBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(100.r),
            //                           borderSide: BorderSide(
            //                               color: const Color.fromARGB(
            //                                   255, 202, 202, 202)),
            //                         ),
            //                         focusedBorder: OutlineInputBorder(
            //                           borderRadius:
            //                               BorderRadius.circular(100.r),
            //                           borderSide: BorderSide(
            //                               color: const Color.fromARGB(
            //                                   255, 202, 202, 202)),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 17.h,
            //                   ),
            //                   Row(
            //                     children: [
            //                       SizedBox(
            //                         width: 23.w,
            //                       ),
            //                       Text(
            //                         "New on Takkul",
            //                         style: TextStyle(
            //                           color: Color(0xff20402A),
            //                           fontSize: 18.sp,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                   SizedBox(
            //                     height: 9.h,
            //                   ),
            //                   Container(
            //                     height: 245.h,
            //                     width: ScreenUtil().screenWidth,
            //                     child: ListView.builder(
            //                       shrinkWrap: true,
            //                       scrollDirection: Axis.horizontal,
            //                       itemCount: Modelclass.thirdListView.length,
            //                       itemBuilder: (context, index) {
            //                         return InkWell(
            //                           onTap: () {
            //                             Get.to(
            //                                 () => RestaurantMenuScreen(
            //                                       model: Modelclass
            //                                           .thirdListView[index],
            //                                     ),
            //                                 transition:
            //                                     Transition.leftToRight);
            //                           },
            //                           child: Row(
            //                             children: [
            //                               SizedBox(
            //                                 width: 23.w,
            //                               ),
            //                               Card(
            //                                 elevation: 0,
            //                                 child: Container(
            //                                   height: 245.h,
            //                                   width: 283.w,
            //                                   decoration: BoxDecoration(
            //                                     color: Colors.white,
            //                                     borderRadius:
            //                                         BorderRadius.only(
            //                                       topLeft:
            //                                           Radius.circular(11.r),
            //                                       topRight:
            //                                           Radius.circular(11.r),
            //                                     ),
            //                                   ),
            //                                   child: Column(
            //                                     children: [
            //                                       Stack(
            //                                         children: [
            //                                           Container(
            //                                             height: 157.h,
            //                                             width: 283.w,
            //                                             decoration:
            //                                                 BoxDecoration(
            //                                               color: const Color
            //                                                   .fromARGB(
            //                                                   255, 0, 0, 0),
            //                                               borderRadius:
            //                                                   BorderRadius
            //                                                       .only(
            //                                                 topLeft: Radius
            //                                                     .circular(
            //                                                         11.r),
            //                                                 topRight: Radius
            //                                                     .circular(
            //                                                         11.r),
            //                                               ),
            //                                               image:
            //                                                   DecorationImage(
            //                                                 image: AssetImage(
            //                                                   Modelclass
            //                                                       .thirdListView[
            //                                                           index]
            //                                                       .listofimages![0],
            //                                                 ),
            //                                                 fit: BoxFit.cover,
            //                                               ),
            //                                             ),
            //                                             child: Stack(
            //                                               children: [
            //                                                 Column(
            //                                                   children: [
            //                                                     SizedBox(
            //                                                       height: 9.h,
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width:
            //                                                               12.w,
            //                                                         ),
            //                                                         Container(
            //                                                           height:
            //                                                               26.h,
            //                                                           width:
            //                                                               95.w,
            //                                                           decoration:
            //                                                               BoxDecoration(
            //                                                             color:
            //                                                                 Color(0xff383736).withOpacity(0.8),
            //                                                             borderRadius:
            //                                                                 BorderRadius.all(
            //                                                               Radius.circular(20),
            //                                                             ),
            //                                                           ),
            //                                                           child:
            //                                                               Center(
            //                                                             child:
            //                                                                 Text(
            //                                                               Modelclass.thirdListView[index].firstHeading!,
            //                                                               style:
            //                                                                   TextStyle(
            //                                                                 color: Colors.white,
            //                                                                 fontWeight: FontWeight.w500,
            //                                                                 fontSize: 11.83.sp,
            //                                                               ),
            //                                                             ),
            //                                                           ),
            //                                                         ),
            //                                                         SizedBox(
            //                                                           width:
            //                                                               135.w,
            //                                                         ),
            //                                                         Container(
            //                                                           height:
            //                                                               27.h,
            //                                                           width:
            //                                                               27.w,
            //                                                           decoration:
            //                                                               BoxDecoration(
            //                                                             color:
            //                                                                 Color(0xff383736).withOpacity(0.8),
            //                                                             shape:
            //                                                                 BoxShape.circle,
            //                                                           ),
            //                                                           child: Image(
            //                                                               image:
            //                                                                   AssetImage("images/heart.png")),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                     SizedBox(
            //                                                       height: 9.h,
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width:
            //                                                               12.w,
            //                                                         ),
            //                                                         Container(
            //                                                           height:
            //                                                               24.18.h,
            //                                                           width:
            //                                                               65.95.w,
            //                                                           decoration:
            //                                                               BoxDecoration(
            //                                                             color:
            //                                                                 Color(0xff20402A),
            //                                                             borderRadius:
            //                                                                 BorderRadius.all(
            //                                                               Radius.circular(20),
            //                                                             ),
            //                                                           ),
            //                                                           child:
            //                                                               Center(
            //                                                             child:
            //                                                                 Text(
            //                                                               Modelclass.thirdListView[index].secondHeading!,
            //                                                               style:
            //                                                                   TextStyle(
            //                                                                 color: Colors.white,
            //                                                                 fontWeight: FontWeight.w500,
            //                                                                 fontSize: 11.83.sp,
            //                                                               ),
            //                                                             ),
            //                                                           ),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                     SizedBox(
            //                                                       height:
            //                                                           50.h,
            //                                                     ),
            //                                                     Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width:
            //                                                               12.w,
            //                                                         ),
            //                                                         Text(
            //                                                           Modelclass
            //                                                               .thirdListView[index]
            //                                                               .thirdHeading!,
            //                                                           style:
            //                                                               TextStyle(
            //                                                             color:
            //                                                                 Colors.white,
            //                                                             fontSize:
            //                                                                 16.17.sp,
            //                                                             fontWeight:
            //                                                                 FontWeight.w700,
            //                                                           ),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                   ],
            //                                                 )
            //                                               ],
            //                                             ),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                       Padding(
            //                                         padding:
            //                                             const EdgeInsets.only(
            //                                                 top: 10),
            //                                         child: Container(
            //                                           // color: Colors.amber,
            //                                           child: Column(
            //                                             mainAxisAlignment:
            //                                                 MainAxisAlignment
            //                                                     .spaceEvenly,
            //                                             children: [
            //                                               Row(
            //                                                 children: [
            //                                                   Image(
            //                                                     image: AssetImage(
            //                                                         "images/2xtime.png"),
            //                                                     height: 22.h,
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 8.w,
            //                                                   ),
            //                                                   Text(
            //                                                     Modelclass
            //                                                         .thirdListView[
            //                                                             index]
            //                                                         .time!,
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: const Color
            //                                                           .fromARGB(
            //                                                           255,
            //                                                           5,
            //                                                           4,
            //                                                           4),
            //                                                       fontSize:
            //                                                           13.sp,
            //                                                       fontWeight:
            //                                                           FontWeight
            //                                                               .w500,
            //                                                     ),
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 105.w,
            //                                                   ),
            //                                                   Container(
            //                                                     height:
            //                                                         24.67.h,
            //                                                     width:
            //                                                         54.83.w,
            //                                                     decoration:
            //                                                         BoxDecoration(
            //                                                       color: Color(
            //                                                           0xffFFC107),
            //                                                       borderRadius:
            //                                                           BorderRadius
            //                                                               .all(
            //                                                         Radius.circular(
            //                                                             20),
            //                                                       ),
            //                                                     ),
            //                                                     child: Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width:
            //                                                               9.w,
            //                                                         ),
            //                                                         Image(
            //                                                             image:
            //                                                                 AssetImage("images/Star 1.png")),
            //                                                         SizedBox(
            //                                                           width:
            //                                                               5.w,
            //                                                         ),
            //                                                         Text(
            //                                                           "${Modelclass.thirdListView[index].rating!}   ",
            //                                                           style:
            //                                                               TextStyle(
            //                                                             color:
            //                                                                 Colors.white,
            //                                                             fontWeight:
            //                                                                 FontWeight.w500,
            //                                                             fontSize:
            //                                                                 12.21.sp,
            //                                                           ),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                               Row(
            //                                                 children: [
            //                                                   Image(
            //                                                     image: AssetImage(
            //                                                         "images/loc2x.png"),
            //                                                     height: 22.h,
            //                                                   ),
            //                                                   SizedBox(
            //                                                     width: 8.w,
            //                                                   ),
            //                                                   Text(
            //                                                     Modelclass
            //                                                         .thirdListView[
            //                                                             index]
            //                                                         .location!,
            //                                                     style:
            //                                                         TextStyle(
            //                                                       color: Colors
            //                                                           .black,
            //                                                       fontSize:
            //                                                           13.sp,
            //                                                       fontWeight:
            //                                                           FontWeight
            //                                                               .w500,
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ],
            //                                           ),
            //                                         ),
            //                                       )
            //                                     ],
            //                                   ),
            //                                 ),
            //                               ),
            //                             ],
            //                           ),
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     height: 17.h,
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.only(left: 23.w),
            //                     child: Align(
            //                       alignment: Alignment.topLeft,
            //                       child: Text(
            //                         "Around You",
            //                         style: TextStyle(
            //                           color: Color(0xff20402A),
            //                           fontSize: 18.sp,
            //                           fontWeight: FontWeight.w600,
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     child: ListView.builder(
            //                       padding: EdgeInsets.only(bottom: 80),
            //                       shrinkWrap: true,
            //                       physics: NeverScrollableScrollPhysics(),
            //                       scrollDirection: Axis.vertical,
            //                       itemCount: Modelclass.thirdListView.length,
            //                       itemBuilder: (context, index) {
            //                         return Row(
            //                           children: [
            //                             SizedBox(
            //                               width: 23.w,
            //                             ),
            //                             Card(
            //                               elevation: 0,
            //                               child: Container(
            //                                 height: 237.h,
            //                                 width: 338.w,
            //                                 decoration: BoxDecoration(
            //                                   color: Colors.white,
            //                                   borderRadius: BorderRadius.only(
            //                                     topLeft:
            //                                         Radius.circular(11.r),
            //                                     topRight:
            //                                         Radius.circular(11.r),
            //                                   ),
            //                                 ),
            //                                 child: Column(
            //                                   children: [
            //                                     Stack(
            //                                       children: [
            //                                         Container(
            //                                           height: 157.h,
            //                                           width: 338.w,
            //                                           decoration:
            //                                               BoxDecoration(
            //                                             color: const Color
            //                                                 .fromARGB(
            //                                                 255, 0, 0, 0),
            //                                             borderRadius:
            //                                                 BorderRadius.only(
            //                                               topLeft:
            //                                                   Radius.circular(
            //                                                       11.r),
            //                                               topRight:
            //                                                   Radius.circular(
            //                                                       11.r),
            //                                             ),
            //                                             image:
            //                                                 DecorationImage(
            //                                               image: AssetImage(
            //                                                 Modelclass
            //                                                     .thirdListView[
            //                                                         index]
            //                                                     .listofimages![0],
            //                                               ),
            //                                               fit: BoxFit.cover,
            //                                             ),
            //                                           ),
            //                                           child: Stack(
            //                                             children: [
            //                                               Column(
            //                                                 children: [
            //                                                   SizedBox(
            //                                                     height: 9.h,
            //                                                   ),
            //                                                   Row(
            //                                                     children: [
            //                                                       SizedBox(
            //                                                         width:
            //                                                             12.w,
            //                                                       ),
            //                                                       Container(
            //                                                         height:
            //                                                             26.h,
            //                                                         width:
            //                                                             95.w,
            //                                                         decoration:
            //                                                             BoxDecoration(
            //                                                           color: Color(0xff383736)
            //                                                               .withOpacity(0.8),
            //                                                           borderRadius:
            //                                                               BorderRadius.all(
            //                                                             Radius.circular(
            //                                                                 20),
            //                                                           ),
            //                                                         ),
            //                                                         child:
            //                                                             Center(
            //                                                           child:
            //                                                               Text(
            //                                                             Modelclass
            //                                                                 .thirdListView[index]
            //                                                                 .firstHeading!,
            //                                                             style:
            //                                                                 TextStyle(
            //                                                               color:
            //                                                                   Colors.white,
            //                                                               fontWeight:
            //                                                                   FontWeight.w500,
            //                                                               fontSize:
            //                                                                   11.83.sp,
            //                                                             ),
            //                                                           ),
            //                                                         ),
            //                                                       ),
            //                                                       SizedBox(
            //                                                         width:
            //                                                             189.w,
            //                                                       ),
            //                                                       Container(
            //                                                         height:
            //                                                             27.h,
            //                                                         width:
            //                                                             27.w,
            //                                                         decoration:
            //                                                             BoxDecoration(
            //                                                           color: Color(0xff383736)
            //                                                               .withOpacity(0.8),
            //                                                           shape: BoxShape
            //                                                               .circle,
            //                                                         ),
            //                                                         child: Image(
            //                                                             image:
            //                                                                 AssetImage("images/heart.png")),
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                   SizedBox(
            //                                                     height: 9.h,
            //                                                   ),
            //                                                   Row(
            //                                                     children: [
            //                                                       SizedBox(
            //                                                         width:
            //                                                             12.w,
            //                                                       ),
            //                                                       Container(
            //                                                         height:
            //                                                             24.18
            //                                                                 .h,
            //                                                         width:
            //                                                             65.95
            //                                                                 .w,
            //                                                         decoration:
            //                                                             BoxDecoration(
            //                                                           color: Color(
            //                                                               0xff20402A),
            //                                                           borderRadius:
            //                                                               BorderRadius.all(
            //                                                             Radius.circular(
            //                                                                 20),
            //                                                           ),
            //                                                         ),
            //                                                         child:
            //                                                             Center(
            //                                                           child:
            //                                                               Text(
            //                                                             Modelclass
            //                                                                 .thirdListView[index]
            //                                                                 .secondHeading!,
            //                                                             style:
            //                                                                 TextStyle(
            //                                                               color:
            //                                                                   Colors.white,
            //                                                               fontWeight:
            //                                                                   FontWeight.w500,
            //                                                               fontSize:
            //                                                                   11.83.sp,
            //                                                             ),
            //                                                           ),
            //                                                         ),
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                   SizedBox(
            //                                                     height: 50.h,
            //                                                   ),
            //                                                   Row(
            //                                                     children: [
            //                                                       SizedBox(
            //                                                         width:
            //                                                             12.w,
            //                                                       ),
            //                                                       Text(
            //                                                         Modelclass
            //                                                             .thirdListView[
            //                                                                 index]
            //                                                             .thirdHeading!,
            //                                                         style:
            //                                                             TextStyle(
            //                                                           color: Colors
            //                                                               .white,
            //                                                           fontSize:
            //                                                               16.17.sp,
            //                                                           fontWeight:
            //                                                               FontWeight.w700,
            //                                                         ),
            //                                                       ),
            //                                                     ],
            //                                                   ),
            //                                                 ],
            //                                               )
            //                                             ],
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     Expanded(
            //                                       child: Container(
            //                                         height: 200.h,
            //                                         color: Colors.white,
            //                                         child: Column(
            //                                           mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .spaceEvenly,
            //                                           children: [
            //                                             Row(
            //                                               children: [
            //                                                 Image(
            //                                                   image: AssetImage(
            //                                                       "images/2xtime.png"),
            //                                                   height: 22.h,
            //                                                 ),
            //                                                 SizedBox(
            //                                                   width: 8.w,
            //                                                 ),
            //                                                 Text(
            //                                                   Modelclass
            //                                                       .thirdListView[
            //                                                           index]
            //                                                       .time!,
            //                                                   style:
            //                                                       TextStyle(
            //                                                     color: const Color
            //                                                         .fromARGB(
            //                                                         255,
            //                                                         5,
            //                                                         4,
            //                                                         4),
            //                                                     fontSize:
            //                                                         13.sp,
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .w500,
            //                                                   ),
            //                                                 ),
            //                                                 SizedBox(
            //                                                   width: 155.w,
            //                                                 ),
            //                                                 Padding(
            //                                                   padding:
            //                                                       const EdgeInsets
            //                                                           .only(
            //                                                           top:
            //                                                               10),
            //                                                   child:
            //                                                       Container(
            //                                                     height:
            //                                                         24.67.h,
            //                                                     width:
            //                                                         54.83.w,
            //                                                     decoration:
            //                                                         BoxDecoration(
            //                                                       color: Color(
            //                                                           0xffFFC107),
            //                                                       borderRadius:
            //                                                           BorderRadius
            //                                                               .all(
            //                                                         Radius.circular(
            //                                                             20),
            //                                                       ),
            //                                                     ),
            //                                                     child: Row(
            //                                                       children: [
            //                                                         SizedBox(
            //                                                           width:
            //                                                               9.w,
            //                                                         ),
            //                                                         Image(
            //                                                             image:
            //                                                                 AssetImage("images/Star 1.png")),
            //                                                         SizedBox(
            //                                                           width:
            //                                                               5.w,
            //                                                         ),
            //                                                         Text(
            //                                                           "${Modelclass.thirdListView[index].rating!}   ",
            //                                                           style:
            //                                                               TextStyle(
            //                                                             color:
            //                                                                 Colors.white,
            //                                                             fontWeight:
            //                                                                 FontWeight.w500,
            //                                                             fontSize:
            //                                                                 12.21.sp,
            //                                                           ),
            //                                                         ),
            //                                                       ],
            //                                                     ),
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                             Row(
            //                                               children: [
            //                                                 Image(
            //                                                   image: AssetImage(
            //                                                       "images/loc2x.png"),
            //                                                   height: 22.h,
            //                                                 ),
            //                                                 SizedBox(
            //                                                   width: 8.w,
            //                                                 ),
            //                                                 Text(
            //                                                   Modelclass
            //                                                       .thirdListView[
            //                                                           index]
            //                                                       .location!,
            //                                                   style:
            //                                                       TextStyle(
            //                                                     color: Colors
            //                                                         .black,
            //                                                     fontSize:
            //                                                         13.sp,
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .w500,
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           ],
            //                                         ),
            //                                       ),
            //                                     )
            //                                   ],
            //                                 ),
            //                               ),
            //                             ),
            //                           ],
            //                         );
            //                       },
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             )
            //           : Stack(
            //               children: [
            //                 Container(
            //                     height: ScreenUtil().screenHeight,
            //     width: ScreenUtil().screenWidth,

            //                   child: Image(image: AssetImage("images/map (1).png"))),
            //                 Column(
            //                   children: [
            //                     SizedBox(
            //                       height: 118.h,
            //                     ),
            //                     Center(
            //                       child: Container(
            //                         width: 335.w,
            //                         height: 53.h,
            //                         child: TextFormField(
            //                           controller: searchcontroller,
            //                           cursorColor: Colors.grey,
            //                           decoration: InputDecoration(
            //                             contentPadding:
            //                                 const EdgeInsets.symmetric(
            //                                     vertical: 17.0,
            //                                     horizontal: 10.0),
            //                             hintText: "Search",
            //                             filled: true,
            //                             fillColor: Colors.white,
            //                             prefixIcon: Image(
            //                                 image: AssetImage(
            //                                     "images/Layer 2.png")),
            //                             suffixIcon: Image(
            //                                 image: AssetImage(
            //                                     "images/Vector.png")),
            //                             border: InputBorder.none,
            //                             hintStyle: TextStyle(
            //                               color: Color(0xff4B4B4B),
            //                               fontSize: 14.sp,
            //                             ),
            //                             enabledBorder: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(100.r),
            //                               borderSide: BorderSide(
            //                                   color: const Color.fromARGB(
            //                                       255, 202, 202, 202)),
            //                             ),
            //                             focusedBorder: OutlineInputBorder(
            //                               borderRadius:
            //                                   BorderRadius.circular(100.r),
            //                               borderSide: BorderSide(
            //                                   color: const Color.fromARGB(
            //                                       255, 202, 202, 202)),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       height: 397.h,
            //                     ),
            //                     Container(
            //                     //  width: 340.w,
            //                      height: 160.h,
            //                       child: ListView.builder(
            //                       padding: EdgeInsets.symmetric(
            //                         horizontal: 10.w
            //                       ),
            //                         shrinkWrap: true,
            //                       //  physics: NeverScrollableScrollPhysics(),
            //                         scrollDirection: Axis.horizontal,
            //                         itemCount: Modelclass
            //                             .thirdListView[0].deals!.length,
            //                         itemBuilder:
            //                             (BuildContext context, int index) {
            //                           return Padding(
            //                             padding: EdgeInsets.symmetric(
            //                             vertical: 20.h,
            //                                 horizontal: 10.w),
            //                             child: InkWell(
            //                               onTap: () {
            //                                 Get.to(QuantitySelectedScreen(
            //                                   model: Modelclass
            //                                       .thirdListView[0]
            //                                       .deals![index],
            //                                 ));
            //                               },
            //                               child: Container(
            //                                 height: 113.h,
            //                                 width: 334.w,
            //                                 decoration: BoxDecoration(
            //                                   color: Colors.red,
            //                                   borderRadius:
            //                                       BorderRadius.circular(6.r),
            //                                   border: Border.all(
            //                                     color: Color(0xffFFC107),
            //                                     width: 1,
            //                                   ),
            //                                 ),
            //                                 child: Center(
            //                                   child: Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       Padding(
            //                                         padding:
            //                                             const EdgeInsets.only(
            //                                                 top: 21),
            //                                         child: Row(
            //                                           mainAxisAlignment:
            //                                               MainAxisAlignment
            //                                                   .spaceEvenly,
            //                                           children: [
            //                                             Column(
            //                                               crossAxisAlignment:
            //                                                   CrossAxisAlignment
            //                                                       .start,
            //                                               children: [
            //                                                 Text(
            //                                                   Modelclass
            //                                                       .thirdListView[
            //                                                           0]
            //                                                       .deals![
            //                                                           index]
            //                                                       .title!,
            //                                                   style:
            //                                                       TextStyle(
            //                                                     color: Color(
            //                                                         0xff20402A),
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .w600,
            //                                                     fontSize:
            //                                                         14.sp,
            //                                                   ),
            //                                                 ),
            //                                                 Text(
            //                                                   Modelclass
            //                                                       .thirdListView[
            //                                                           0]
            //                                                       .deals![
            //                                                           index]
            //                                                       .description!,
            //                                                   style:
            //                                                       TextStyle(
            //                                                     color: Color(
            //                                                         0xff20402A),
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .w400,
            //                                                     fontSize:
            //                                                         11.9.sp,
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                             Stack(
            //                                               children: [
            //                                                 Container(
            //                                                   height: 69.h,
            //                                                   width: 94.w,
            //                                                   decoration:
            //                                                       BoxDecoration(
            //                                                           borderRadius:
            //                                                               BorderRadius.circular(4.12.r),
            //                                                           image: DecorationImage(
            //                                                               image: AssetImage(
            //                                                             Modelclass
            //                                                                 .thirdListView[0]
            //                                                                 .deals![index]
            //                                                                 .image![0],
            //                                                           ))),
            //                                                 ),
            //                                                 Padding(
            //                                                   padding:
            //                                                       const EdgeInsets
            //                                                           .only(
            //                                                           top: 5),
            //                                                   child:
            //                                                       Container(
            //                                                     height: 21.h,
            //                                                     width: 82.w,
            //                                                     decoration:
            //                                                         BoxDecoration(
            //                                                             color: Colors
            //                                                                 .white,
            //                                                             borderRadius:
            //                                                                 BorderRadius.only(
            //                                                               bottomRight:
            //                                                                   Radius.circular(12.99.r),
            //                                                               topRight:
            //                                                                   Radius.circular(12.99.r),
            //                                                             )),
            //                                                     child: Stack(
            //                                                       children: [
            //                                                         Row(
            //                                                           mainAxisAlignment:
            //                                                               MainAxisAlignment.spaceAround,
            //                                                           children: [
            //                                                             Image(
            //                                                               image:
            //                                                                   AssetImage(
            //                                                                 "images/paper-bag 1 (1).png",
            //                                                               ),
            //                                                               height:
            //                                                                   13.18.h,
            //                                                               width:
            //                                                                   13.18.w,
            //                                                             ),
            //                                                             Text(
            //                                                               "Only ${Modelclass.thirdListView[0].deals![index].noofitems!} left  ",
            //                                                               style:
            //                                                                   TextStyle(
            //                                                                 color: Colors.black,
            //                                                                 fontSize: 11.sp,
            //                                                                 fontWeight: FontWeight.w500,
            //                                                               ),
            //                                                             )
            //                                                           ],
            //                                                         )
            //                                                       ],
            //                                                     ),
            //                                                   ),
            //                                                 )
            //                                               ],
            //                                             )
            //                                           ],
            //                                         ),
            //                                       ),
            //                                       Row(
            //                                         children: [
            //                                           Padding(
            //                                             padding:
            //                                                 const EdgeInsets
            //                                                     .only(
            //                                                     left: 20),
            //                                             child: Stack(
            //                                               children: [
            //                                                 Text(
            //                                                   "AED ${Modelclass.thirdListView[0].deals![index].pricing!}",
            //                                                   style:
            //                                                       TextStyle(
            //                                                     color: Color(
            //                                                         0xffDE5B33),
            //                                                     fontWeight:
            //                                                         FontWeight
            //                                                             .w600,
            //                                                     fontSize:
            //                                                         11.69.sp,
            //                                                   ),
            //                                                 ),
            //                                                 Padding(
            //                                                   padding:
            //                                                       const EdgeInsets
            //                                                           .only(
            //                                                     top: 10,
            //                                                   ),
            //                                                   child:
            //                                                       Container(
            //                                                     height: 2.h,
            //                                                     width: 50.w,
            //                                                     color: Color(
            //                                                         0xffDE5B33),
            //                                                   ),
            //                                                 ),
            //                                               ],
            //                                             ),
            //                                           ),
            //                                           SizedBox(
            //                                             width: 5.w,
            //                                           ),
            //                                           Text(
            //                                             "AED ${Modelclass.thirdListView[0].deals![index].priceafterdiscount!}",
            //                                             style: TextStyle(
            //                                               color: Color(
            //                                                   0xff20402A),
            //                                               fontWeight:
            //                                                   FontWeight.w600,
            //                                               fontSize: 13.sp,
            //                                             ),
            //                                           ),
            //                                           SizedBox(
            //                                             width: 145.w,
            //                                           ),
            //                                           Text(
            //                                             "${Modelclass.thirdListView[0].deals![index].discount!}% OFF",
            //                                             style: TextStyle(
            //                                               color: Color(
            //                                                   0xffD49F00),
            //                                               fontWeight:
            //                                                   FontWeight.w600,
            //                                               fontSize: 13.sp,
            //                                             ),
            //                                           ),
            //                                         ],
            //                                       )
            //                                     ],
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                           );
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //     ]),
            //   ),
            // ),
          ]),
          index == 0
              ? SizedBox()
              : Column(
                  children: [
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
                            color:
                                index == 0 ? Colors.white : Color(0xff20402A),
                            text: 'Store List',
                            Font: FontWeight.w400,
                            fontsize: 12.34.sp,
                          ),
                          width: 136.67.w,
                          height: 36.54.h,
                          onPressed: () {
                            index = 0;
                            setState(() {});
                          },
                          backcolor:
                              index == 0 ? Color(0xff20402A) : Colors.white,
                        ),
                        CustomButtons(
                          borderRadius: 100.r,
                          child: ButtonText(
                            color:
                                index == 0 ? Color(0xff20402A) : Colors.white,
                            text: 'See on Map',
                            Font: FontWeight.w400,
                            fontsize: 12.34.sp,
                          ),
                          width: 136.67.w,
                          height: 36.54.h,
                          onPressed: () {
                            index = 1;
                            setState(() {});
                          },
                          backcolor:
                              index == 0 ? Colors.white : Color(0xff20402A),
                        ),
                      ],
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
