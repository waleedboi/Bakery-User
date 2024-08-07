import 'dart:developer';

import 'package:completefoodorderingappui/modelclasshome.dart';
import 'package:completefoodorderingappui/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritiesSecondScreen extends StatefulWidget {
  const FavoritiesSecondScreen({super.key});

  @override
  State<FavoritiesSecondScreen> createState() => _FavoritiesSecondScreenState();
}

class _FavoritiesSecondScreenState extends State<FavoritiesSecondScreen> {
  bool light = false;

  List<bool> buttonslist =
      List.generate(Modelclass.thirdListView.length, (index) => false);

  @override
  Widget build(BuildContext context) {
    log("list $buttonslist");
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  height: 100.h,
                  width: ScreenUtil().screenWidth,
                  color: const Color(0xff20402A),
                  child: Padding(
                    padding: EdgeInsets.only(top: 55.h),
                    child: AppBarClass(
                      text: "Your favourite stores",
                      color: Colors.white,
                      iconcolor: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.only(
                        top: 20.h,
                        bottom: 80.h,
                      ),
                      itemCount: Modelclass.thirdListView.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(
                              width: 18.w,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Card(
                                // used for shadoww
                                elevation: 5,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.r),
                                ),
                                child: Container(
                                  height: 300.h,
                                  width: 338.w,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(11.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 157.h,
                                            width: 338.w,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(11.r),
                                                topRight: Radius.circular(11.r),
                                              ),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                  Modelclass
                                                      .thirdListView[index]
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                    0xff383736)
                                                                .withOpacity(
                                                                    0.8),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  20),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              Modelclass
                                                                  .thirdListView[
                                                                      index]
                                                                  .firstHeading!,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize:
                                                                    11.83.sp,
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color: const Color(
                                                                    0xff383736)
                                                                .withOpacity(
                                                                    0.8),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: const Image(
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
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0xff20402A),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  20),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              Modelclass
                                                                  .thirdListView[
                                                                      index]
                                                                  .secondHeading!,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                                                          width: 12.w,
                                                        ),
                                                        Text(
                                                          Modelclass
                                                              .thirdListView[
                                                                  index]
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
                                      Expanded(
                                        child: SizedBox(
                                          height: 200.h,
                                          // color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Image(
                                                    image: const AssetImage(
                                                        "images/2xtime.png"),
                                                    height: 22.h,
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Text(
                                                    Modelclass
                                                        .thirdListView[index]
                                                        .time!,
                                                    style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 5, 4, 4),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 155.w,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Container(
                                                      height: 24.67.h,
                                                      width: 54.83.w,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0xffFFC107),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 9.w,
                                                          ),
                                                          const Image(
                                                              image: AssetImage(
                                                                  "images/Star 1.png")),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Text(
                                                            "${Modelclass.thirdListView[index].rating!}   ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
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
                                                    image: const AssetImage(
                                                        "images/loc2x.png"),
                                                    height: 22.h,
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  Text(
                                                    Modelclass
                                                        .thirdListView[index]
                                                        .location!,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: 14.w,
                                                  ),
                                                  Text(
                                                    "Notify me when baskets are available",
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 35.w,
                                                  ),
                                                  Transform.scale(
                                                    scale: 1,
                                                    child: Switch.adaptive(
                                                      activeColor: Colors.green,
                                                      // Don't use the ambient CupertinoThemeData to style this switch.
                                                      applyCupertinoTheme:
                                                          false,
                                                      value: buttonslist[index],
                                                      onChanged: (bool value) {
                                                        setState(() {
                                                          buttonslist[index] =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 70.82.h,
              width: 371.27.w,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border.fromBorderSide(BorderSide(
                    color: Color.fromARGB(255, 182, 182, 182),
                  )
                      //color: Colors.grey,
                      )),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(
                    image: AssetImage("images/bottomnav.png"),
                    height: 17.25,
                  ),
                  Image(
                    image: AssetImage("images/bottomheart.png"),
                    height: 17.02,
                  ),
                  Image(
                    image: AssetImage("images/bottomkitchen.png"),
                    height: 21.79,
                  ),
                  Image(
                    image: AssetImage("images/bottomprofile.png"),
                    height: 17.25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
