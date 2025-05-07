import 'package:flutter/material.dart';

class Modelclass {
  String? firstHeading;
  String? secondHeading;
  String? thirdHeading;
  bool? favorite;
  String? time;
  double? rating;
  String? location;
  String? description;

  List<String>? listofimages;

  List<DealsModel>? deals;
  Modelclass({
    required this.firstHeading,
    required this.secondHeading,
    required this.thirdHeading,
    required this.favorite,
    required this.time,
    required this.rating,
    required this.location,
    required this.description,
    required this.deals,
    required this.listofimages,

  });
  static List<Modelclass> thirdListView = [
    Modelclass(
      firstHeading: 'From AED 20',
      secondHeading: 'Bakery',
      thirdHeading: " The Bakery LLC & Cake Shop",
      listofimages: ["images/Group 14078.png", "images/Group 14070.png"],
      deals: [
        DealsModel(
          title: "Salade",
          description:
              "Fresh organic Salade. 100% healthy\nand tasty. Natural body booster.",
          pricing: 345,
          priceafterdiscount: 54,
          discount: 50,
           image: ["images/Rectangle 94.png","images/Group 14077.png"],
          noofitems: 1,
           bakeryname: 'The Bakery LLC & Cake Shop', pickupbetween: '09:00-16:00',
          
          
        ),
        DealsModel(
          title: "Salade",
          description:
              "Fresh organic Salade. 100% healthy\nand tasty. Natural body booster.",
          pricing: 345,
          priceafterdiscount: 54,
          discount: 50,
           image: ["images/Rectangle 94.png","images/Group 14077.png"],
          noofitems: 1,
          bakeryname: 'The Bakery LLC & Cake Shop', pickupbetween: '09:00-16:00',
        )
      ],
      time: "09:00-16:00",
      favorite: false,
      rating: 5.0,
      location: "25 m - Al Barsha 1, Al Rabwah, Shop\n No. 11 - Dubai",
      description: "One of the best finest Bakery Shop in Dubai.",
    ),
    Modelclass(
      firstHeading: 'From AED 20',
      secondHeading: 'Bakery',
      thirdHeading: " The Bakery LLC & Cake Shop",
      listofimages: ["images/Group 14077.png"],
      deals: [
        DealsModel(
          title: "Salade",
          description:
              "Fresh organic Salade. 100% healthy \nand tasty. Natural body booster.",
          pricing: 345,
          priceafterdiscount: 54,
          discount: 50,
          image: ["images/Rectangle 94.png","images/Group 14077.png"],
          noofitems: 1,
          bakeryname: 'The Bakery LLC & Cake Shop', pickupbetween: '09:00-16:00',
        ),
        DealsModel(
          title: "Salade",
          description:
              "Fresh organic Salade. 100% healthy \nand tasty. Natural body booster.",
          pricing: 345,
          priceafterdiscount: 54,
          discount: 50,
          image: ["images/Rectangle 94.png","images/Group 14077.png"],
          noofitems: 1,
          bakeryname: 'The Bakery LLC & Cake Shop', pickupbetween: '09:00-16:00',
        ),
        DealsModel(
          title: "Salade",
          description:
              "Fresh organic Salade. 100% healthy \nand tasty. Natural body booster.",
          pricing: 345,
          priceafterdiscount: 54,
          discount: 50,
           image: ["images/Rectangle 94.png","images/Group 14077.png"],
          noofitems: 1,
          bakeryname: 'The Bakery LLC & Cake Shop', pickupbetween: '09:00-16:00',
        )
      ],
      time: "09:00-16:00",
      favorite: false,
      rating: 5.0,
      location: "25 m - Al Barsha 1, Al Rabwah, Shop\n No. 11 - Dubai",
      description: "One of the best finest Bakery Shop in Dubai.",
    ),
  ];
}

class DealsModel {
  String? title;
  String? description;
  int? pricing;
  int? priceafterdiscount;
  int? discount;
 List<String>? image;
  int? noofitems;
  String? bakeryname;
  String? pickupbetween;

  DealsModel({
    required this.title,
    required this.description,
    required this.pricing,
    required this.priceafterdiscount,
    required this.discount,
    required this.image,
    required this.noofitems,
     required this.bakeryname,
      required this.pickupbetween,
  });
}
