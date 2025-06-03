import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/order_card.dart';

class ActiveOrders extends StatelessWidget {
  const ActiveOrders({super.key});

  Future<void> updateOrderStatus(String orderId, String status) async {
    await FirebaseFirestore.instance.collection('orders').doc(orderId).update({
      'status': status,
    });
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
        'title': status == 'completed' ? 'Order Delivered' : 'Order Cancelled',
        'body': status == 'completed'
            ? 'Your order from $bakeryName has been delivered.'
            : 'We\'re sorry, but your order from $bakeryName has been cancelled.',
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
            .where('status', isEqualTo: 'active')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
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
                    showActiveActions: true,
                    onDelivered: () async {
                      try {
                        await updateOrderStatus(order['orderId'], 'completed');
                        await createNotificationInDatabase(
                          customerId: order['customerId'],
                          status: 'completed',
                          bakeryName: order['bakeryName'],
                          orderId: order['orderId'],
                        );
                        
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Order marked as delivered')),
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
                    onCancel: () async {
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
                            const SnackBar(content: Text('Order cancelled')),
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

