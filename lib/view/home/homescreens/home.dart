import 'package:completefoodorderingappui/models/bakery_model.dart';
import 'package:completefoodorderingappui/see_on_map/see_on_map.dart';
import 'package:completefoodorderingappui/view/home/bakery_details/bakery_details.dart';
import 'package:completefoodorderingappui/view/home/bakery_list/bakery_list.dart';
import 'package:completefoodorderingappui/view/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchcontroller = TextEditingController();
  String searchQuery = '';
  int index = 0;
  Future<List<BakeryModel>> fetchBakeries() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('admins').get();
      
      return querySnapshot.docs.map((doc) {
        return BakeryModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error fetching bakeries: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == 1
          ? null
          : AppBar(
              leading: const SizedBox(),
              toolbarHeight: 100,
              backgroundColor: const Color(0xffEEEEE6),
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Image(image: AssetImage("images/Group 13405.png")),
                      CustomButtons(
                        borderRadius: 100.r,
                        width: 136.67.w,
                        height: 36.54.h,
                        onPressed: () {
                          index = 0;
                          setState(() {});
                        },
                        backcolor:
                            index == 0 ? const Color(0xff20402A) : Colors.white,
                        child: ButtonText(
                          color: index == 0
                              ? Colors.white
                              : const Color(0xff20402A),
                          text: 'Store List',
                          Font: FontWeight.w400,
                          fontsize: 12.34.sp,
                        ),
                      ),
                      CustomButtons(
                        borderRadius: 100.r,
                        width: 136.67.w,
                        height: 36.54.h,
                        onPressed: () {
                          index = 1;
                          setState(() {});
                        },
                        backcolor:
                            index == 0 ? Colors.white : const Color(0xff20402A),
                        child: ButtonText(
                          color: index == 0
                              ? const Color(0xff20402A)
                              : Colors.white,
                          text: 'See on Map',
                          Font: FontWeight.w400,
                          fontsize: 12.34.sp,
                        ),
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
                      color: const Color(0xffEEEEE6),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Column(
                            children: [
                              SizedBox(
                                height: 23.h,
                              ),
                              SizedBox(
                                width: 335.w,
                                height: 53.h,
                                child: TextFormField(
                                  controller: searchcontroller,
                                  cursorColor: Colors.grey,
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery = value.toLowerCase();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 17.0, horizontal: 10.0),
                                    hintText: "Search",
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: const Image(
                                        image:
                                            AssetImage("images/Layer 2.png")),
                                    suffixIcon: const Image(
                                        image: AssetImage("images/Vector.png")),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: const Color(0xff4B4B4B),
                                      fontSize: 14.sp,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 202, 202, 202)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.r),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 202, 202, 202)),
                                    ),
                                  ),
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
                                      color: const Color(0xff20402A),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10,),
                              FutureBuilder<List<BakeryModel>>(
                                future: fetchBakeries(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return const Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return const Center(child: Text('No bakeries found'));
                                  } else {
                                    final bakeries = searchQuery.isEmpty
                                        ? snapshot.data!
                                        : snapshot.data!.where((bakery) =>
                                            bakery.bakeryName.toLowerCase().contains(searchQuery)).toList();
                                    
                                    return ListView.builder(
                                      padding: const EdgeInsets.only(bottom: 80),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: bakeries.length,
                                      itemBuilder: (context, index) {
                                        return BakeryListItem(
                                          bakery: bakeries[index],
                                          onTap: () {
                                            Get.to(
                                              () => RestaurantMenuScreen(
                                                model: bakeries[index],
                                              ),
                                              transition: Transition.leftToRight,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  )
                : const Expanded(
                    child: SeeOnMapScreen()
                  ),
          ]),
          index == 0
              ? const SizedBox()
              : Column(
                  children: [
                    SizedBox(
                      height: 44.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                            image: AssetImage("images/Group 13405.png")),
                        CustomButtons(
                          borderRadius: 100.r,
                          width: 136.67.w,
                          height: 36.54.h,
                          onPressed: () {
                            index = 0;
                            setState(() {});
                          },
                          backcolor: index == 0
                              ? const Color(0xff20402A)
                              : Colors.white,
                          child: ButtonText(
                            color: index == 0
                                ? Colors.white
                                : const Color(0xff20402A),
                            text: 'Store List',
                            Font: FontWeight.w400,
                            fontsize: 12.34.sp,
                          ),
                        ),
                        CustomButtons(
                          borderRadius: 100.r,
                          width: 136.67.w,
                          height: 36.54.h,
                          onPressed: () {
                            index = 1;
                            setState(() {});
                          },
                          backcolor: index == 0
                              ? Colors.white
                              : const Color(0xff20402A),
                          child: ButtonText(
                            color: index == 0
                                ? const Color(0xff20402A)
                                : Colors.white,
                            text: 'See on Map',
                            Font: FontWeight.w400,
                            fontsize: 12.34.sp,
                          ),
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