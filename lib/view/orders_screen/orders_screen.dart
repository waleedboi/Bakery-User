import 'package:completefoodorderingappui/view/orders_screen/provider/order_provider.dart';
import 'package:completefoodorderingappui/view/orders_screen/widgets/bakery_rating.dart';
import 'package:completefoodorderingappui/view/orders_screen/widgets/noorder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);

    Future.microtask(
        () => Provider.of<OrderProvider>(context, listen: false).fetchOrders());
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        primary: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xff20402A),
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text("My Orders",style: TextStyle(color: Colors.white),),
        ),
      ),
      backgroundColor: const Color(0xffEEEEE6),
      body: Column(
        children: [
          const SizedBox(height: 30,),
          Container(
            height: 40.h,
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36.r),
            ),
            child: TabBar(
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(36.r),
                color: const Color(0xff1B4332),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle:
                  TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              tabs: const [
                Tab(text: 'Pending'),
                Tab(text: 'Accepted'),
                Tab(text: 'Rejected'),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: Consumer<OrderProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return TabBarView(
                  controller: _tabController,
                  children: [
                    provider.pendingOrders.isEmpty
                        ? noOrder()
                        : buildOrdersList(provider.pendingOrders),
                    provider.acceptedOrders.isEmpty
                        ? noOrder()
                        : buildOrdersList(provider.acceptedOrders),
                    provider.rejectedOrders.isEmpty
                        ? noOrder()
                        : buildOrdersList(provider.rejectedOrders),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 80,)
        ],
      ),
    );
  }

  Widget buildOrdersList(List<Map<String, dynamic>> orders) {
    return ListView.builder(
      itemCount: orders.length,
      padding: EdgeInsets.all(16.w),
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Order ID: ${order['orderId']}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text("Bakery: ${order['bakeryName']}",
                    style: TextStyle(fontSize: 13.sp)),
                SizedBox(height: 4.h),
                Text("Status: ${order['status'] ?? 'N/A'}",
                    style: TextStyle(fontSize: 13.sp, color: Colors.blue)),
                SizedBox(height: 8.h),
                ...List.generate(order['items'].length, (i) {
                  final item = order['items'][i];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    title: Text(item['itemName'],
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    subtitle: Text("Qty: ${item['quantity']}"),
                    trailing: Text("Rs ${item['itemPrice']}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    leading: item['imageUrl'] != null &&
                            item['imageUrl'].toString().isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              item['imageUrl'],
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                width: 40.w,
                                height: 40.w,
                                color: Colors.grey[300],
                                child: Icon(Icons.image_not_supported,
                                    color: Colors.grey[600]),
                              ),
                            ),
                          )
                        : Container(
                            width: 40.w,
                            height: 40.w,
                            color: Colors.grey[300],
                            child:
                                Icon(Icons.food_bank, color: Colors.grey[600]),
                          ),
                  );
                }),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: Rs ${order['totalAmount']}",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.bold)),
                    Text(
                        'Payment ${order['paymentStatus'].toString().toLowerCase()}',
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff1B4332),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: () {
                      final bakeryId = order['bakeryId'];
                      if (bakeryId != null) {
                        showRatingDialog(bakeryId, context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Bakery ID not found!")),
                        );
                      }
                    },
                    child: Text("Rate Bakery",
                        style: TextStyle(fontSize: 12.sp, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
