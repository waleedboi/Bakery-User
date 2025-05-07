import 'package:completefoodorderingappui/models/modelclasshome.dart';
import 'package:flutter/material.dart';

class OrderModel {
  String? heading;
  String? status;
  String? description;
  String? date;
  String? location;
  int? rating;

  OrderModel({
    required this.heading,
    required this.status,
    required this.description,
    required this.date,
    required this.location,
    required this.rating,
  });
  static List<OrderModel> orderslist = [
    OrderModel(
        heading: "Pastries Box",
        rating: 0,
        status: "confirmed",
        description: "Eat Greek Kozina Food Bakery Restauraut",
        date: "09:00 - 16:00",
        location: "25 m - AL Barsha 1, AL Rabwah,Shop No. 11"),
    OrderModel(
        heading: "Pastries Box",
        rating: 0,
        status: "pending",
        description: "Eat Greek Kozina Food Bakery Restauraut",
        date: "09:00 - 16:00",
        location: "25 m - AL Barsha 1, AL Rabwah,Shop No. 11"),
    OrderModel(
        heading: "Pastries",
        rating: 5,
        status: "completed",
        description: "Eat Greek Kozina Food Bakery Restauraut",
        date: "09:00 - 16:00",
        location: ""),
    OrderModel(
        heading: "Pastries",
        rating: 3,
        status: "cancelled",
        description: "Eat Greek Kozina Food Bakery Restauraut",
        date: "09:00 - 16:00",
        location: ""),
  ];
}
