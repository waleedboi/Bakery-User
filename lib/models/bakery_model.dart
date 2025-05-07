import 'package:cloud_firestore/cloud_firestore.dart';

class BakeryModel {
  final String id;
  final String bakeryName;
  final String bakeryDescription;
  final String bakeryTiming;
  final String bakeryLocation;
  final double bakeryReview;
  final String firstHeading;
  final String secondHeading;
  final String thirdHeading;
  final List<String> listofimages;
  final dynamic deals;
  final List<String> items;

  BakeryModel({
    required this.id,
    required this.bakeryName,
    required this.bakeryDescription,
    required this.bakeryTiming,
    required this.bakeryLocation,
    required this.bakeryReview,
    required this.firstHeading,
    required this.secondHeading,
    required this.thirdHeading,
    required this.listofimages,
    this.deals,
    required this.items,
  });

  factory BakeryModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    // Handle itemsList extraction
    List<String> itemsList = [];
    if (data['items'] != null) {
      if (data['items'] is List) {
        itemsList = List<String>.from(data['items']);
      } else if (data['items'] is Map) {
        itemsList = (data['items'] as Map)
            .values
            .map((item) => item.toString())
            .toList();
      }
    }

    List<String> imagesList = [];
    if (data['imageUrls'] != null && data['imageUrls'] is List) {
      imagesList = List<String>.from(data['imageUrls']);
    } else if (data['listofimages'] != null && data['listofimages'] is List) {
      imagesList = List<String>.from(data['listofimages']);
    } else if (data['bakeryImage'] != null) {
      if (data['bakeryImage'] is String) {
        imagesList = [data['bakeryImage']];
      } else if (data['bakeryImage'] is List) {
        imagesList = List<String>.from(data['bakeryImage']);
      }
    }

    if (imagesList.isEmpty) {
      imagesList = ['images/placeholder.png'];
    }

    return BakeryModel(
      id: doc.id,
      bakeryName: data['bakeryName'] ?? 'Unknown Bakery',
      bakeryDescription: data['bakeryDescription'] ?? 'No description available',
      bakeryTiming: data['bakeryTiming'] ?? 'Not specified',
      bakeryLocation: data['bakeryLocation'] ?? 'Location not available',
      bakeryReview: (data['bakeryRating'] ?? 0.0).toDouble(),
      firstHeading: data['firstHeading'] ?? 'FREE DELIVERY',
      secondHeading: data['secondHeading'] ?? 'ORGANIC',
      thirdHeading: data['thirdHeading'] ?? 'Unknown Bakery',
      listofimages: imagesList,
      deals: data['deals'] ?? [],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bakeryName': bakeryName,
      'bakeryDescription': bakeryDescription,
      'bakeryTiming': bakeryTiming,
      'bakeryLocation': bakeryLocation,
      'bakeryReview': bakeryReview,
      'firstHeading': firstHeading,
      'secondHeading': secondHeading,
      'thirdHeading': thirdHeading,
      'imageUrls': listofimages,
      'deals': deals,
      'items': items,
    };
  }
}