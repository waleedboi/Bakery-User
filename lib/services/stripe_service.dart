import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StripeService {
  static Future<Map<String, dynamic>?> createPaymentIntent({
    required String amount,
    required String currency,
    required String customerId,
    required String orderId,
    required String adminId,
  }) async {
    try {
      // Get admin's Stripe details
      final adminDoc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminId)
          .get();

      if (!adminDoc.exists) {
        throw 'Admin not found';
      }

      final adminData = adminDoc.data()!;
      final secretKey = adminData['stripeSecretKey'];
      final accountId = adminData['stripeAccountId'];

      if (secretKey == null || accountId == null) {
        throw 'Stripe not set up for this bakery';
      }

      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
          'Stripe-Account': accountId,
        },
        body: {
          'amount': amount,
          'currency': currency,
          'metadata[customer_id]': customerId,
          'metadata[order_id]': orderId,
          'automatic_payment_methods[enabled]': 'true',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error creating payment intent: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception during payment intent creation: $e');
      return null;
    }
  }

  static Future<void> initializePaymentSheet({
    required String paymentIntentClientSecret,
    required String adminId,
  }) async {
    try {
      final adminDoc = await FirebaseFirestore.instance
          .collection('admins')
          .doc(adminId)
          .get();

      if (!adminDoc.exists) {
        throw 'Admin not found';
      }

      final adminData = adminDoc.data()!;
      final publishableKey = adminData['stripePublishableKey'];
      final accountId = adminData['stripeAccountId'];

      if (publishableKey == null || accountId == null) {
        throw 'Stripe not set up for this bakery';
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: adminData['bakeryName'] ?? 'Bakery',
          customerId: null,
          customerEphemeralKeySecret: null,
          setupIntentClientSecret: null,
          customFlow: false,
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xff1B4332),
            ),
          ),
        ),
      );
    } catch (e) {
      print('Error initializing payment sheet: $e');
      rethrow;
    }
  }
} 