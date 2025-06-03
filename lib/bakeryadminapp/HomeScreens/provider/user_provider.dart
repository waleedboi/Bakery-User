import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserData {
  final String name;
  final double revenue;
  final int totalOrders;
  final int totalRatings;
  final double bakeryRating;
  final Map<String, dynamic>? ratingBreakdown;

  UserData({
    this.name = '',
    this.revenue = 0.0,
    this.totalOrders = 0,
    this.totalRatings = 0,
    this.bakeryRating = 0.0,
    this.ratingBreakdown,
  });

  factory UserData.fromMap(Map<String, dynamic>? map) {
    if (map == null) return UserData();

    return UserData(
      name: map['name'] ?? '',
      revenue:
          map['revenue'] != null ? (map['revenue'] as num).toDouble() : 0.0,
      totalOrders: map['totalOrders'] ?? 0,
      totalRatings: map['totalRatings'] ?? 0,
      bakeryRating: map['bakeryRating'] != null
          ? (map['bakeryRating'] as num).toDouble()
          : 0.0,
      ratingBreakdown: map['ratingBreakdown'] as Map<String, dynamic>?,
    );
  }
}

class UserProvider extends ChangeNotifier {
  UserData _userData = UserData();
  bool _isLoading = false;
  String? _error;

  UserData get userData => _userData;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchCurrentUserData() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        throw Exception('No user is currently logged in');
      }

      final DocumentSnapshot userDoc =
          await _firestore.collection('admins').doc(user.uid).get();

      if (!userDoc.exists) {
        throw Exception('User data not found in admins collection');
      }

      final Map<String, dynamic> userData =
          userDoc.data() as Map<String, dynamic>;

      _userData = UserData.fromMap(userData);
      _isLoading = false;
      notifyListeners();

      print(
          'User data loaded: ${_userData.name}, Revenue: ${_userData.revenue}, Orders: ${_userData.totalOrders}, Ratings: ${_userData.totalRatings}, Average Rating: ${_userData.bakeryRating}');
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshUserData() async {
    await fetchCurrentUserData();
  }

  Map<String, double> getRatingDistribution() {
    if (_userData.ratingBreakdown != null) {
      try {
        return {
          'excellent':
              (_userData.ratingBreakdown!['excellent'] as num).toDouble(),
          'good': (_userData.ratingBreakdown!['good'] as num).toDouble(),
          'satisfactory':
              (_userData.ratingBreakdown!['satisfactory'] as num).toDouble(),
          'bad': (_userData.ratingBreakdown!['bad'] as num).toDouble(),
        };
      } catch (e) {
        print('Error parsing rating breakdown: $e');
      }
    }

    final rating = _userData.bakeryRating;

    if (rating >= 4.5) {
      return {
        'excellent': 0.75,
        'good': 0.20,
        'satisfactory': 0.04,
        'bad': 0.01,
      };
    } else if (rating >= 4.0) {
      return {
        'excellent': 0.60,
        'good': 0.30,
        'satisfactory': 0.08,
        'bad': 0.02,
      };
    } else if (rating >= 3.0) {
      return {
        'excellent': 0.30,
        'good': 0.40,
        'satisfactory': 0.25,
        'bad': 0.05,
      };
    } else {
      return {
        'excellent': 0.10,
        'good': 0.20,
        'satisfactory': 0.40,
        'bad': 0.30,
      };
    }
  }

  Map<String, double> getPerformanceMetrics() {
    final rating = _userData.bakeryRating;
    final excellentBase = (rating / 5) * 0.8 + 0.1;

    return {
      'excellent': excellentBase,
      'timelyDeliveries':
          excellentBase + 0.1 > 0.95 ? 0.95 : excellentBase + 0.1,
      'qualityOfDeliverable':
          excellentBase - 0.2 < 0.1 ? 0.1 : excellentBase - 0.2,
    };
  }
}
