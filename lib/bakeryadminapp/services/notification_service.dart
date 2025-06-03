import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

class MessagingService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Make sure this path matches exactly where you placed your service account JSON file
  static const _serviceAccountPath = "assets/food.json";
  static const _projectId = "ecomm-ff529"; // Your Firebase project ID
  static const _fcmApiUrl = "https://fcm.googleapis.com/v1/projects/ecomm-ff529/messages:send";
  static const List<String> _scopes = ["https://www.googleapis.com/auth/firebase.messaging"];

  static Future<void> init() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    _messaging.onTokenRefresh.listen((newToken) {
      _updateTokenInDatabase(newToken);
    });

    final token = await _messaging.getToken();
    if (token != null) {
      log('FCM Token: $token'); // Log the token for debugging
      await _updateTokenInDatabase(token);
    }
  }

  static Future<void> _updateTokenInDatabase(String token) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        final userRef = _firestore.collection('users').doc(userId);
        
        // First check if the document exists
        final docSnapshot = await userRef.get();
        if (docSnapshot.exists) {
          await userRef.update({
            "tokens": FieldValue.arrayUnion([token])
          });
        } else {
          // Create the document if it doesn't exist
          await userRef.set({
            "tokens": [token]
          }, SetOptions(merge: true));
        }
        log('Token saved to database successfully');
      } catch (e) {
        log('Error updating token in database: $e');
      }
    }
  }

  static Future<void> removeTokenFromDatabase(String token) async {
    final userId = _auth.currentUser?.uid;
    if (userId != null) {
      try {
        final userRef = _firestore.collection('users').doc(userId);
        await userRef.update({
          "tokens": FieldValue.arrayRemove([token])
        });
        log('Token removed from database successfully');
      } catch (e) {
        log('Error removing token from database: $e');
      }
    }
  }

  static Future<String> _getAccessToken() async {
    try {
      log('Loading service account file...');
      final serviceAccountJson = await rootBundle.loadString(_serviceAccountPath);
      log('Service account file loaded successfully');
      
      final credentials = ServiceAccountCredentials.fromJson(
        json.decode(serviceAccountJson)
      );
      
      log('Creating auth client...');
      final client = http.Client();
      final authClient = await clientViaServiceAccount(credentials, _scopes);
      final accessToken = authClient.credentials.accessToken.data;
      
      log('Access token obtained successfully');
      client.close();
      authClient.close();
      
      return accessToken;
    } catch (e) {
      log('Error getting access token: $e');
      // Print the stack trace for more detailed debugging
      log(StackTrace.current.toString());
      return '';
    }
  }

  static Future<void> sendNotification({
    required List<String> tokens,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    log('Attempting to send notification to ${tokens.length} tokens');
    
    if (tokens.isEmpty) {
      log('No tokens provided, aborting notification');
      return;
    }
    
    final accessToken = await _getAccessToken();
    if (accessToken.isEmpty) {
      log('Failed to obtain access token, aborting notification');
      return;
    }
    
    log('Access token obtained, sending notifications...');
    
    for (String token in tokens) {
      log('Sending notification to token: $token');
      
      final Map<String, dynamic> notificationPayload = {
        "message": {
          "token": token,
          "notification": {
            "title": title,
            "body": body,
          },
          "android": {
            "priority": "high",
            "notification": {
              "sound": "default"
            }
          },
          "apns": {
            "payload": {
              "aps": {
                "sound": "default"
              }
            }
          }
        }
      };
      
      // Add optional data payload if provided
      if (data != null) {
        notificationPayload["message"]["data"] = data;
      }

      try {
        log('Sending request to FCM API');
        final response = await http.post(
          Uri.parse(_fcmApiUrl),
          headers: {
            "Authorization": "Bearer $accessToken",
            "Content-Type": "application/json",
          },
          body: jsonEncode(notificationPayload),
        );

        log('FCM response status code: ${response.statusCode}');
        log('FCM response body: ${response.body}');

        if (response.statusCode == 200) {
          log('Notification sent successfully to $token');
        } else {
          log('Error sending notification: ${response.statusCode}, ${response.body}');
          
          final responseBody = json.decode(response.body);
          final errorDetails = responseBody['error']?['details'];
          
          if (errorDetails != null && errorDetails.isNotEmpty) {
            final errorCode = errorDetails[0]?['errorCode'];
            if (errorCode == 'UNREGISTERED') {
              log('Token is unregistered. Removing token from database.');
              await removeTokenFromDatabase(token);
            }
          }
        }
      } catch (e) {
        log('Exception sending notification: $e');
        log(StackTrace.current.toString());
      }
    }
  }
}