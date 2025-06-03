import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/bakeryadminapp/notifications/order_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return [];

    final ordersSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('adminId', isEqualTo: currentUser.uid)
        .orderBy('orderDate', descending: true)
        .get();

    List<Map<String, dynamic>> orders = [];

    for (var doc in ordersSnapshot.docs) {
      final data = doc.data();
      final customerId = data['customerId'];

      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(customerId)
          .get();

      final customerName = userSnapshot.data()?['name'] ?? 'Unknown';

      // Determine notification type based on order status or other criteria
      String notificationType = _getNotificationType(data);

      orders.add({
        'bakeryName': data['bakeryName'],
        'orderDate': data['orderDate'],
        'totalAmount': data['totalAmount'],
        'items': data['items'],
        'customerName': customerName,
        'notificationType': notificationType,
        'orderId': doc.id,
      });
    }

    return orders;
  }

  String _getNotificationType(Map<String, dynamic> data) {
    // You can implement logic here to determine notification type
    // For now, alternating between types for demonstration
    final status = data['status'] ?? '';
    if (status == 'delivered') {
      return 'Order Delivered';
    } else if (status == 'out_for_delivery') {
      return 'Out For Delivery';
    } else {
      return 'New Order';
    }
  }

  String formatDate(DateTime dateTime) {
    final DateFormat timeFormat = DateFormat('HH:mm');
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return '${timeFormat.format(dateTime)} ${dateFormat.format(dateTime)}';
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'Order Delivered':
        return Colors.green;
      case 'Out For Delivery':
        return Colors.orange;
      case 'New Order':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'Order Delivered':
        return Icons.check_circle;
      case 'Out For Delivery':
        return Icons.local_shipping;
      case 'New Order':
        return Icons.shopping_bag;
      default:
        return Icons.notifications;
    }
  }

  String _getNotificationMessage(Map<String, dynamic> order) {
    switch (order['notificationType']) {
      case 'Order Delivered':
        return 'Get discount codes from sharing with friends';
      case 'Out For Delivery':
        return 'Your order #${order['orderId'].substring(0, 6)} is on its way';
      case 'New Order':
        return 'New order from ${order['customerName']}';
      default:
        return 'Order notification';
    }
  }

  Widget _buildNotificationIcon(String type) {
    Color color = _getNotificationColor(type);
    IconData icon = _getNotificationIcon(type);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _buildNotificationIndicator(String type) {
    if (type == 'Out For Delivery') {
      return Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchOrders(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                        child: Text('Error loading notifications'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No notifications found'));
                  }

                  final now = DateTime.now();
                  final today = DateTime(now.year, now.month, now.day);
                  final yesterday = today.subtract(const Duration(days: 1));

                  Map<String, List<Map<String, dynamic>>> groupedOrders = {};

                  for (var order in snapshot.data!) {
                    DateTime orderDate = order['orderDate'].toDate();
                    DateTime orderDay = DateTime(
                        orderDate.year, orderDate.month, orderDate.day);

                    String section;
                    if (orderDay == today) {
                      section = 'Today';
                    } else if (orderDay == yesterday) {
                      section = 'Yesterday';
                    } else {
                      section = DateFormat('dd MMM yyyy').format(orderDate);
                    }

                    groupedOrders.putIfAbsent(section, () => []).add(order);
                  }

                  return ListView(
                    children: groupedOrders.entries.map((entry) {
                      final sectionTitle = entry.key;
                      final sectionOrders = entry.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              sectionTitle,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          ...sectionOrders.map((order) {
                            final notificationType = order['notificationType'];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderDetailsScreen(order: order),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          _buildNotificationIcon(
                                              notificationType),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: _buildNotificationIndicator(
                                                notificationType),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notificationType,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _getNotificationMessage(order),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        formatDate(order['orderDate'].toDate()),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
