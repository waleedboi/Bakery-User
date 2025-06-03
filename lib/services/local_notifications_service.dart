import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = 
      FlutterLocalNotificationsPlugin();
  
  static bool _isInitialized = false;
  static int _notificationId = 0;

  // Initialize the notification service
  static Future<void> initialize() async {
    if (_isInitialized) return;
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
        
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _notificationsPlugin.initialize(
      initializationSettings,
    );
    
    _isInitialized = true;
    debugPrint('Local Notification Service initialized');
  }
  
  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    if (!_isInitialized) await initialize();
    
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'order_status_channel',
      'Order Status Notifications',
      channelDescription: 'Notifications about your bakery orders',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );
    
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    
    await _notificationsPlugin.show(
      _notificationId++,
      title,
      body,
      platformChannelSpecifics,
    );
    
    debugPrint('Showed notification: $title - $body');
  }
  
  static Future<void> checkForNewNotifications() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;
      
      debugPrint('Checking for new notifications for user: ${currentUser.uid}');
      
      final notificationsSnapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('recipientId', isEqualTo: currentUser.uid)
          .where('isRead', isEqualTo: false)
          .orderBy('createdAt', descending: true)
          .get();
      
      if (notificationsSnapshot.docs.isEmpty) {
        debugPrint('No new notifications found');
        return;
      }
      
      debugPrint('Found ${notificationsSnapshot.docs.length} new notifications');
      
      if (!_isInitialized) await initialize();
      
      for (var doc in notificationsSnapshot.docs) {
        final data = doc.data();
        await showNotification(
          title: data['title'] ?? 'New Notification',
          body: data['body'] ?? '',
        );
        
        await FirebaseFirestore.instance
            .collection('notifications')
            .doc(doc.id)
            .update({'isRead': true});
      }
    } catch (e) {
      debugPrint('Error checking for new notifications: $e');
    }
  }
  
  static Stream<QuerySnapshot> getNotificationStream() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }
    
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('recipientId', isEqualTo: currentUser.uid)
        .where('isRead', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}