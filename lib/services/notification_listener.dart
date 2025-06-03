import 'package:completefoodorderingappui/services/local_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationsHandler extends StatefulWidget {
  final Widget child;
  
  const NotificationsHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<NotificationsHandler> createState() => _NotificationsHandlerState();
}

class _NotificationsHandlerState extends State<NotificationsHandler> {
  late Stream<QuerySnapshot> _notificationsStream;
  bool _isStreamInitialized = false;
  
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }
  
  Future<void> _initializeNotifications() async {
    // Initialize the local notification service
    await LocalNotificationService.initialize();
    
    // Make sure Firebase Auth is initialized before accessing currentUser
    if (FirebaseAuth.instance.currentUser != null) {
      // Set up the stream
      _notificationsStream = LocalNotificationService.getNotificationStream();
      _isStreamInitialized = true;
      
      // Check for existing notifications on start
      await LocalNotificationService.checkForNewNotifications();
      
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isStreamInitialized) {
      return widget.child;
    }
    
    return StreamBuilder<QuerySnapshot>(
      stream: _notificationsStream,
      builder: (context, snapshot) {
        // Process new notifications when they arrive
        if (snapshot.hasData && snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
          // This will be called whenever there are new notifications
          // Use a microtask to avoid build phase modification
          Future.microtask(() => _processNewNotifications(snapshot.data!.docs));
        }
        
        // Return the child widget
        return widget.child;
      },
    );
  }
  
  Future<void> _processNewNotifications(List<QueryDocumentSnapshot> notifications) async {
    // Create a set to track processed notification IDs
    final Set<String> processedIds = {};
    
    for (var doc in notifications) {
      // Skip if we've already processed this notification
      if (processedIds.contains(doc.id)) continue;
      
      processedIds.add(doc.id);
      final data = doc.data() as Map<String, dynamic>;
      
      // Show local notification
      await LocalNotificationService.showNotification(
        title: data['title'] ?? 'New Notification',
        body: data['body'] ?? '',
      );
      
      // Mark as read
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(doc.id)
          .update({'isRead': true});
    }
  }
}