import 'package:completefoodorderingappui/utilis/utilis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<Map<String, String>> faqs = [
    {
      "question": "1. How can I track my order?",
      "answer":
          "You can track your order in real-time by going to 'My Orders' and selecting the ongoing order. You'll see the delivery status and estimated time of arrival."
    },
    {
      "question": "2. Can I cancel my order after placing it?",
      "answer":
          "Yes, you can cancel the order within 5 minutes of placing it. Go to 'My Orders' and tap on 'Cancel Order'."
    },
    {
      "question": "3. How do I request a refund?",
      "answer":
          "If your order was incorrect or not delivered, you can request a refund by contacting support through the 'Contact Support' section."
    },
    {
      "question": "4. What payment methods do you support?",
      "answer":
          "We support all major payment methods including Credit/Debit Cards, Google Pay, Apple Pay, and Cash on Delivery (COD)."
    },
    {
      "question": "5. How do I change my delivery address?",
      "answer":
          "You can update your delivery address from your profile settings or during checkout before placing the order."
    },
    {
      "question": "6. Is there a delivery charge?",
      "answer":
          "A minimal delivery fee may apply depending on your location and restaurant policies. It will be shown before confirming the order."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        color: const Color(0xffEEEEE6),
        child: Column(
          children: [
            SizedBox(height: 55.h),
            AppBarClass(
              text: 'FAQs',
              color: const Color(0xff20402A),
              iconcolor: const Color(0xff1B4332),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: 319.w,
              height: 577.h,
              child: SingleChildScrollView(
                child: Column(
                  children: faqs.map((faq) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          faq["question"]!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        SizedBox(
                          width: 290.w,
                          child: Text(
                            faq["answer"]!,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff696965),
                            ),
                          ),
                        ),
                        SizedBox(height: 25.h),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
