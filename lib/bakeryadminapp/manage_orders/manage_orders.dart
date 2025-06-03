import 'package:completefoodorderingappui/bakeryadminapp/manage_orders/sub_screens/active_orders.dart';
import 'package:completefoodorderingappui/bakeryadminapp/manage_orders/sub_screens/delivered_orders.dart';
import 'package:completefoodorderingappui/bakeryadminapp/manage_orders/sub_screens/pending_orders.dart';
import 'package:completefoodorderingappui/bakeryadminapp/manage_orders/sub_screens/rejected_orders.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  _ManageOrdersScreenState createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  int totalOrders = 0;
  int pendingOrders = 0;
  int activeOrders = 0;
  int deliveredOrders = 0;
  int rejectedOrders = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    fetchOrderCounts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchOrderCounts() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return;

    final ordersSnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('adminId', isEqualTo: currentUser.uid)
        .get();

    setState(() {
      totalOrders = ordersSnapshot.docs.length;
      pendingOrders =
          ordersSnapshot.docs.where((doc) => doc['status'] == 'pending').length;
      activeOrders =
          ordersSnapshot.docs.where((doc) => doc['status'] == 'active').length;
      deliveredOrders = ordersSnapshot.docs
          .where((doc) => doc['status'] == 'completed')
          .length;
      rejectedOrders = ordersSnapshot.docs
          .where((doc) => doc['status'] == 'rejected')
          .length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffEEEEE6),
        title: const Text('Manage Orders'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Text(
          //     'Total Orders: $totalOrders',
          //     style: const TextStyle(fontSize: 20),
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: const Color(0xff1B4332),
              ),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Active'),
                Tab(text: 'Delivered'),
                Tab(text: 'Rejected'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PendingOrders(),
                ActiveOrders(),
                DeliveredOrders(),
                RejectedOrders(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
