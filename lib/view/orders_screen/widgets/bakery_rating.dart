import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void showRatingDialog(String bakeryId, BuildContext context) {
  double ratingValue = 3.0;

  showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Rate this Bakery"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RatingBar.builder(
              initialRating: ratingValue,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                ratingValue = rating;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(ctx).pop();
                await updateBakeryRating(bakeryId, ratingValue, context);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      );
    },
  );
}
Future<void> updateBakeryRating(
    String bakeryId, double newRating, BuildContext context) async {
  final docRef =
      FirebaseFirestore.instance.collection('admins').doc(bakeryId);

  try {
    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bakery not found!")),
      );
      return;
    }

    final data = snapshot.data()!;
    final currentRating = (data['bakeryRating'] ?? 0).toDouble();
    final totalRatings = (data['totalRatings'] ?? 0).toInt();

    final newTotalRatings = totalRatings + 1;
    final newAverageRating =
        ((currentRating * totalRatings) + newRating) / newTotalRatings;

    await docRef.update({
      'bakeryRating': double.parse(newAverageRating.toStringAsFixed(1)),
      'totalRatings': newTotalRatings,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thank you for your feedback!")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to submit rating: $e")),
    );
  }
}
