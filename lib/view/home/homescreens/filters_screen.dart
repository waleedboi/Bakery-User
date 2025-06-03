import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FiltersScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onFiltersApplied;
  
  const FiltersScreen({
    Key? key,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  // Rating filter
  double minRating = 0.0;

  // Distance filter (in kilometers)
  double maxDistance = 50.0;

  // Time filters (24-hour format)
  int selectedStartHour = 6;
  int selectedEndHour = 23;

  void resetFilters() {
    setState(() {
      minRating = 0.0;
      maxDistance = 50.0;
      selectedStartHour = 6;
      selectedEndHour = 23;
    });
  }

  void applyFilters() {
    Map<String, dynamic> filters = {
      'minRating': minRating,
      'maxDistance': maxDistance,
      'timeRange': {
        'start': selectedStartHour,
        'end': selectedEndHour,
      },
    };
    
    widget.onFiltersApplied(filters);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      appBar: AppBar(
        backgroundColor: const Color(0xff20402A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Filters',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rating Section
            _buildSectionTitle('Minimum Rating'),
            SizedBox(height: 10.h),
            _buildRatingSlider(),
            
            SizedBox(height: 25.h),
            
            // Distance Section
            _buildSectionTitle('Maximum Distance (km)'),
            SizedBox(height: 10.h),
            _buildDistanceSlider(),
            
            SizedBox(height: 25.h),
            
            // Operating Hours Section
            _buildSectionTitle('Operating Hours'),
            SizedBox(height: 10.h),
            _buildTimeRangeSelector(),
            
            SizedBox(height: 40.h),
            
            // Buttons
            Row(
              children: [
                Expanded(
                  child: _buildResetButton(),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: _buildApplyButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xff20402A),
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildRatingSlider() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffE0E0E0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${minRating.toStringAsFixed(1)} ⭐',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff20402A),
                ),
              ),
              Text(
                '5.0 ⭐',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff20402A),
                ),
              ),
            ],
          ),
          Slider(
            value: minRating,
            min: 0.0,
            max: 5.0,
            divisions: 50,
            activeColor: const Color(0xff20402A),
            inactiveColor: Colors.grey[300],
            onChanged: (double value) {
              setState(() {
                minRating = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDistanceSlider() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffE0E0E0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0 km',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff20402A),
                ),
              ),
              Text(
                '${maxDistance.toStringAsFixed(0)} km',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff20402A),
                ),
              ),
            ],
          ),
          Slider(
            value: maxDistance,
            min: 1.0,
            max: 100.0,
            divisions: 99,
            activeColor: const Color(0xff20402A),
            inactiveColor: Colors.grey[300],
            onChanged: (double value) {
              setState(() {
                maxDistance = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffE0E0E0)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedStartHour.toString().padLeft(2, '0')}:00',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff20402A),
                ),
              ),
              Text(
                '${selectedEndHour.toString().padLeft(2, '0')}:00',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff20402A),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'Show bakeries open between these hours',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 15.h),
          RangeSlider(
            values: RangeValues(selectedStartHour.toDouble(), selectedEndHour.toDouble()),
            min: 0,
            max: 23,
            divisions: 23,
            activeColor: const Color(0xff20402A),
            inactiveColor: Colors.grey[300],
            onChanged: (RangeValues values) {
              setState(() {
                selectedStartHour = values.start.round();
                selectedEndHour = values.end.round();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildResetButton() {
    return GestureDetector(
      onTap: resetFilters,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: const Color(0xff20402A)),
        ),
        child: Center(
          child: Text(
            'Reset',
            style: TextStyle(
              color: const Color(0xff20402A),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplyButton() {
    return GestureDetector(
      onTap: applyFilters,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          color: const Color(0xff20402A),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Center(
          child: Text(
            'Apply',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}