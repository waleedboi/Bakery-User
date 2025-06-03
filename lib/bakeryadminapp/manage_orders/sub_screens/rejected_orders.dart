import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/order_card.dart';

class RejectedOrders extends StatelessWidget {
  const RejectedOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('adminId', isEqualTo: currentUserId)
            .where('status', isEqualTo: 'rejected')
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
                    showActions: false,
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
