import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../widgets/order_card.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  Future<void> updateOrderStatus(String orderId, String status) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }

  Future<void> createNotificationInDatabase({
    required String customerId,
    required String status,
    required String bakeryName,
    required String orderId,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'recipientId': customerId,
        'orderId': orderId,
        'title': status == 'active' ? 'Order Accepted' : 'Order Rejected',
        'body': status == 'active'
            ? 'Your order from $bakeryName has been accepted and is being prepared.'
            : 'We\'re sorry, but your order from $bakeryName has been rejected.',
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      debugPrint('Notification created in database for customer: $customerId');
    } catch (e) {
      debugPrint('Error creating notification in database: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('adminId', isEqualTo: currentUserId)
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading orders'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No pending orders found'));
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final orderDoc = orders[index];
              final orderData = orderDoc.data() as Map<String, dynamic>;

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(orderData['customerId'])
                    .get(),
                builder: (context, userSnapshot) {
                  if (!userSnapshot.hasData) {
                    return const SizedBox();
                  }
                  final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                  
                  final order = {
                    ...orderData,
                    'orderId': orderDoc.id,
                    'customerName': userData['name'],
                  };

                  return OrderCard(
                    order: order,
                    showActions: true,
                    onAccept: () async {
                      try {
                        await updateOrderStatus(order['orderId'], 'active');
                        await createNotificationInDatabase(
                          customerId: order['customerId'],
                          status: 'active',
                          bakeryName: order['bakeryName'],
                          orderId: order['orderId'],
                        );
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order Accepted and Notification Created')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                    onReject: () async {
                      try {
                        await updateOrderStatus(order['orderId'], 'rejected');
                        await createNotificationInDatabase(
                          customerId: order['customerId'],
                          status: 'rejected',
                          bakeryName: order['bakeryName'],
                          orderId: order['orderId'],
                        );
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order Rejected and Notification Created')),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}