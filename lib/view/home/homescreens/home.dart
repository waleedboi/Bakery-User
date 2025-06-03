import 'dart:math' as math;

import 'package:completefoodorderingappui/models/bakery_model.dart';
import 'package:completefoodorderingappui/see_on_map/see_on_map.dart';
import 'package:completefoodorderingappui/view/home/bakery_details/bakery_details.dart';
import 'package:completefoodorderingappui/view/home/bakery_list/bakery_list.dart';
import 'package:completefoodorderingappui/view/home/homescreens/filters_screen.dart';
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
  Map<String, dynamic> appliedFilters = {};
  double userLat = 31.5204;
  double userLng = 74.3587;

  Future<List<BakeryModel>> fetchBakeries() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('admins').get();

      return querySnapshot.docs.map((doc) {
        return BakeryModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error fetching bakeries: $e');
      return [];
    }
  }

  Future<List<BakeryModel>> fetchNewestBakeries() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('admins')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        return BakeryModel.fromFirestore(doc);
      }).toList();
    } catch (e) {
      print('Error fetching newest bakeries: $e');
      return [];
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(lat1)) *
            math.cos(_toRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  bool isBakeryOpenInTimeRange(
      String? bakeryTiming, int startHour, int endHour) {
    if (bakeryTiming == null || bakeryTiming.isEmpty) return true;

    try {
      List<String> timeParts = bakeryTiming.split(' - ');
      if (timeParts.length != 2) return true;

      int bakeryStartHour = int.parse(timeParts[0].split(':')[0]);
      int bakeryEndHour = int.parse(timeParts[1].split(':')[0]);

      return bakeryStartHour <= startHour && bakeryEndHour >= endHour;
    } catch (e) {
      print('Error parsing bakery timing: $e');
      return true;
    }
  }

  List<BakeryModel> applyFiltersToList(List<BakeryModel> bakeries) {
    if (appliedFilters.isEmpty) return bakeries;

    return bakeries.where((bakery) {
      double minRating = appliedFilters['minRating'] ?? 0.0;
      if (minRating > 0.0) {
        double bakeryRating = 0.0;
        try {
          var ratingData = bakery.toJson()['bakeryRating'];
          if (ratingData != null) {
            if (ratingData is String) {
              bakeryRating = double.tryParse(ratingData) ?? 0.0;
            } else if (ratingData is num) {
              bakeryRating = ratingData.toDouble();
            }
          }
        } catch (e) {
          print('Error parsing rating: $e');
        }

        if (bakeryRating < minRating) return false;
      }

      double maxDistance = appliedFilters['maxDistance'] ?? 100.0;
      if (maxDistance < 100.0) {
        try {
          String? bakeryLatLng = bakery.toJson()['bakeryLatLng'];
          if (bakeryLatLng!.isNotEmpty) {
            List<String> coords = bakeryLatLng.split(',');
            if (coords.length == 2) {
              double bakeryLat = double.parse(coords[0].trim());
              double bakeryLng = double.parse(coords[1].trim());

              double distance =
                  calculateDistance(userLat, userLng, bakeryLat, bakeryLng);
              if (distance > maxDistance) return false;
            }
          }
        } catch (e) {
          print('Error parsing location: $e');
        }
      }

      Map<String, dynamic> timeRange = appliedFilters['timeRange'] ?? {};
      if (timeRange.isNotEmpty) {
        int startHour = timeRange['start'] ?? 0;
        int endHour = timeRange['end'] ?? 23;

        String? bakeryTiming = bakery.toJson()['bakeryTiming'];
        if (!isBakeryOpenInTimeRange(bakeryTiming, startHour, endHour)) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  void onFiltersApplied(Map<String, dynamic> filters) {
    setState(() {
      appliedFilters = filters;
    });
  }

  void openFiltersScreen() {
    Get.to(
      () => FiltersScreen(onFiltersApplied: onFiltersApplied),
      transition: Transition.rightToLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: index == 1
          ? null
          : AppBar(
              primary: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: const SizedBox(),
              toolbarHeight: 100,
              backgroundColor: const Color(0xffEEEEE6),
              actions: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Image(
                          image: AssetImage("images/logo.png"), width: 70),
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
                                    suffixIcon: GestureDetector(
                                      // onTap: openFiltersScreen,
                                      child: const SizedBox(
                                        width: 60,
                                        height: 50,
                                        child: Image(
                                            image: AssetImage(
                                                "images/Vector.png")),
                                      ),
                                    ),
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
                                height: 10.h,
                              ),
                              FutureBuilder<List<BakeryModel>>(
                                future: searchQuery.isEmpty
                                    ? fetchBakeries()
                                    : null,
                                builder: (context, snapshot) {
                                  if (searchQuery.isNotEmpty) {
                                    return FutureBuilder<List<BakeryModel>>(
                                      future: fetchBakeries(),
                                      builder: (context, searchSnapshot) {
                                        if (searchSnapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (searchSnapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${searchSnapshot.error}'));
                                        } else if (!searchSnapshot.hasData ||
                                            searchSnapshot.data!.isEmpty) {
                                          return const Center(
                                              child: Text('No bakeries found'));
                                        } else {
                                          List<BakeryModel>
                                              searchFilteredBakeries =
                                              searchSnapshot.data!
                                                  .where((bakery) => bakery
                                                      .bakeryName
                                                      .toLowerCase()
                                                      .contains(searchQuery))
                                                  .toList();

                                          final bakeries = applyFiltersToList(
                                              searchFilteredBakeries);

                                          if (bakeries.isEmpty) {
                                            return Center(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 100.h),
                                                child: Text(
                                                  'No bakeries match your search and filters',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    color: Colors.grey,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            );
                                          }

                                          return ListView.builder(
                                            padding: const EdgeInsets.only(
                                                bottom: 80),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
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
                                                    transition:
                                                        Transition.leftToRight,
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        }
                                      },
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 100.h),
                                        child: Text(
                                          'No bakeries found',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    final allBakeries =
                                        applyFiltersToList(snapshot.data!);

                                    if (allBakeries.isEmpty) {
                                      return Center(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 100.h),
                                          child: Text(
                                            'No bakeries match your filters',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: [
                                        FutureBuilder<List<BakeryModel>>(
                                          future: fetchNewestBakeries(),
                                          builder: (context, newestSnapshot) {
                                            if (newestSnapshot.hasData &&
                                                newestSnapshot
                                                    .data!.isNotEmpty) {
                                              final filteredNewest =
                                                  applyFiltersToList(
                                                      newestSnapshot.data!);

                                              if (filteredNewest.isNotEmpty) {
                                                return Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 23.w),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "New On BakeMe",
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xff20402A),
                                                            fontSize: 18.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 260.h,
                                                      child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount:
                                                            filteredNewest
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                            width: 340.h,
                                                            child:
                                                                BakeryListItem(
                                                              bakery:
                                                                  filteredNewest[
                                                                      index],
                                                              onTap: () {
                                                                Get.to(
                                                                  () =>
                                                                      RestaurantMenuScreen(
                                                                    model: filteredNewest[
                                                                        index],
                                                                  ),
                                                                  transition:
                                                                      Transition
                                                                          .leftToRight,
                                                                );
                                                              },
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }
                                            }
                                            return const SizedBox.shrink();
                                          },
                                        ),

                                        // Around You Section
                                        if (allBakeries.isNotEmpty) ...[
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 23.w),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Around You",
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xff20402A),
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListView.builder(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: allBakeries.length,
                                            itemBuilder: (context, index) {
                                              return BakeryListItem(
                                                bakery: allBakeries[index],
                                                onTap: () {
                                                  Get.to(
                                                    () => RestaurantMenuScreen(
                                                      model: allBakeries[index],
                                                    ),
                                                    transition:
                                                        Transition.leftToRight,
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ],
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
                : const Expanded(child: SeeOnMapScreen()),
          ]),
          index == 0
              ? const SizedBox()
              : Column(
                  children: [
                    SizedBox(
                      height: 35.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Image(
                          image: AssetImage("images/logo.png"),
                          width: 70,
                        ),
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
