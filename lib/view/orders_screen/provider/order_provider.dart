import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> _pendingOrders = [];
  List<Map<String, dynamic>> _completedOrders = [];
  List<Map<String, dynamic>> _rejectedOrders = [];
  List<Map<String, dynamic>> _acceptedOrders = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get pendingOrders => _pendingOrders;
  List<Map<String, dynamic>> get completedOrders => _completedOrders;
  List<Map<String, dynamic>> get rejectedOrders => _rejectedOrders;
List<Map<String, dynamic>> get acceptedOrders => _acceptedOrders;
  bool get isLoading => _isLoading;

Future<void> fetchOrders() async {
  _isLoading = true;
  notifyListeners();

  try {
    _pendingOrders = await _getOrdersByStatus('pending');
    _rejectedOrders = await _getOrdersByStatus('rejected');
    final activeOrders = await _getOrdersByStatus('active');
    final completedOrders = await _getOrdersByStatus('completed');

    _acceptedOrders = [...activeOrders, ...completedOrders];

    print('Pending: ${_pendingOrders.length}, Accepted: ${_acceptedOrders.length}');
  } catch (e) {
    print('Error fetching orders: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  Future<List<Map<String, dynamic>>> _getOrdersByStatus(String status) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return [];

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('status', isEqualTo: status)
          .where('customerId', isEqualTo: uid)
          .orderBy('orderDate', descending: true)
          .get();

      print(
          'Query for $status orders returned ${snapshot.docs.length} documents');

      List<Map<String, dynamic>> orders = [];

      for (final doc in snapshot.docs) {
        final data = doc.data();
        final items = data['items'] ?? [];
        final itemDetails = <Map<String, dynamic>>[];

        for (final itemRef in items) {
          final itemSnap = await FirebaseFirestore.instance
              .collection('items')
              .doc(itemRef['itemId'])
              .get();

          if (itemSnap.exists) {
            itemDetails.add({
              'itemName': itemSnap['itemName'],
              'imageUrl': itemSnap['imageUrl'],
              'itemPrice': itemSnap['itemPrice'],
              'quantity': itemRef['quantity'],
            });
          }
        }

        orders.add({
          'orderId': doc.id,
          'bakeryName': data['bakeryName'],
          'totalAmount': data['totalAmount'],
          'paymentStatus': data['paymentStatus'],
          'orderDate': data['orderDate'],
          'status': data['status'],
          'items': itemDetails,
          'bakeryId': data['adminId'],
        });
      }

      return orders;
    } catch (e) {
      print('Error in _getOrdersByStatus: $e');
      return [];
    }
  }
}
