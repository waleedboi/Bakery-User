import 'package:completefoodorderingappui/bakeryadminapp/HomeScreens/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CustomerFeedbackCard extends StatelessWidget {
  const CustomerFeedbackCard({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    
    userProvider.getPerformanceMetrics();
    
    final feedbackData = _getFeedbackData(userProvider);
    final overallRating = userProvider.userData.bakeryRating;

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
                  "Customer Feedback",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            
            // Overall Rating Circle
            CircularPercentIndicator(
              radius: 80.r,
              lineWidth: 12.r,
              animation: true,
              animationDuration: 1500,
              percent: overallRating / 10.0, // Assuming rating is out of 10
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Colors.grey.withOpacity(0.1),
              progressColor: const Color(0xff7DDDD9),
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    overallRating.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    "△ ${_calculateGrowthPercentage(userProvider)}%",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Current Month | Last Month",
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Feedback Categories
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeedbackCategory(
                  "Excellent",
                  feedbackData['excellent']!,
                  const Color(0xff7DDDD9),
                ),
                _buildFeedbackCategory(
                  "Timely Deliveries",
                  feedbackData['timely']!,
                  const Color(0xff7DDDD9),
                ),
                _buildFeedbackCategory(
                  "Quality of Deliverable",
                  feedbackData['quality']!,
                  const Color(0xff7DDDD9),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCategory(String label, double percentage, Color color) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 35.r,
          lineWidth: 6.r,
          animation: true,
          animationDuration: 1200,
          percent: percentage / 100.0,
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey.withOpacity(0.1),
          progressColor: color,
          center: Text(
            "${percentage.toInt()}%",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Map<String, double> _getFeedbackData(UserProvider userProvider) {
    // Calculate feedback percentages based on ratings and orders
    final totalOrders = userProvider.userData.totalOrders;
    final rating = userProvider.userData.bakeryRating;
    
    // Mock calculation - you can replace this with actual data from your provider
    // This simulates realistic feedback percentages based on rating
    double excellentPercent = (rating / 5.0) * 46.0; // Scale to match design
    double timelyPercent = (totalOrders > 50) ? 74.0 : (totalOrders / 50.0) * 74.0;
    double qualityPercent = ((rating / 5.0) * 0.3 + (totalOrders > 20 ? 1.0 : totalOrders / 20.0) * 0.7) * 14.0;
    
    return {
      'excellent': excellentPercent.clamp(0, 100),
      'timely': timelyPercent.clamp(0, 100),
      'quality': qualityPercent.clamp(0, 100),
    };
  }

  String _calculateGrowthPercentage(UserProvider userProvider) {
    // Calculate growth percentage - you can implement actual logic here
    // This is a mock calculation based on current performance
    final rating = userProvider.userData.bakeryRating;
    final orders = userProvider.userData.totalOrders;
    
    // Simple growth calculation - replace with actual month-over-month data
    double growth = ((rating / 5.0) * 15.0 + (orders > 100 ? 10.0 : orders / 10.0));
    return growth.toStringAsFixed(2);
  }
}