import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:completefoodorderingappui/models/bakery_model.dart';
import 'package:completefoodorderingappui/view/fav_bakery/widgets/no_bakery_widget.dart';
import 'package:completefoodorderingappui/view/home/bakery_details/bakery_details.dart';
import 'package:completefoodorderingappui/view/home/bakery_list/bakery_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FavoritiesSecondScreen extends StatelessWidget {
  const FavoritiesSecondScreen({super.key});

  Stream<List<BakeryModel>> getFavoriteBakeries() {
    final user = FirebaseAuth.instance.currentUser;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BakeryModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEEEEE6),
      body: StreamBuilder<List<BakeryModel>>(
        stream: getFavoriteBakeries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
                child: Text('Something went wrong: ${snapshot.error}'));
          }

          final favoriteBakeries = snapshot.data ?? [];

          if (favoriteBakeries.isEmpty) {
            return noBakery();
          }

          return ListView.builder(
            itemCount: favoriteBakeries.length,
            itemBuilder: (context, index) {
              final bakery = favoriteBakeries[index];
              return BakeryListItem(
                bakery: bakery,
                onTap: () {
                  Get.to(
                    () => RestaurantMenuScreen(
                      model: bakery,
                    ),
                    transition: Transition.leftToRight,
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
