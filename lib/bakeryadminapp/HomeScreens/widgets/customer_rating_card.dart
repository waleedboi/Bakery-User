import 'package:completefoodorderingappui/bakeryadminapp/HomeScreens/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomerRatingCard extends StatelessWidget {
  const CustomerRatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final totalRatings = userProvider.userData.totalRatings;
    final bakeryRating = userProvider.userData.bakeryRating;

    userProvider.getPerformanceMetrics();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Customer Ratings",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 60.r,
                      lineWidth: 10.r,
                      animation: true,
                      animationDuration: 1500,
                      percent: _calculateRatingPercent(bakeryRating),
                      circularStrokeCap: CircularStrokeCap.round,
                      backgroundColor: Colors.grey.withOpacity(0.1),
                      progressColor: Colors.blue,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "User",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "$totalRatings",
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...(() {
                        userProvider.getRatingDistribution();
                        return [
                          _buildRatingIndicator("Excellent", Colors.blue),
                          SizedBox(height: 8.h),
                          _buildRatingIndicator("Good", Colors.green),
                          SizedBox(height: 8.h),
                          _buildRatingIndicator(
                              "Satisfactory", Colors.orange),
                          SizedBox(height: 8.h),
                          _buildRatingIndicator("Bad", Colors.red),
                        ];
                      })(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRatingIndicator(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  double _calculateRatingPercent(double rating) {
    return rating / 5.0;
  }
}
