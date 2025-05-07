import 'package:flutter/material.dart';

class CartItem {
  final String itemId;
  final String itemName;
  final int itemPrice; 
  int quantity;
  final String bakeryName;
  final String imageUrl;

  CartItem({
    required this.itemId,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.bakeryName,
    required this.imageUrl,
  });

  int get totalPrice => itemPrice * quantity;

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'quantity': quantity,
      'bakeryName': bakeryName,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      itemId: map['itemId'] ?? '',
      itemName: map['itemName'] ?? '',
      itemPrice: map['itemPrice'] ?? 0,
      quantity: map['quantity'] ?? 0,
      bakeryName: map['bakeryName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  int get totalAmount {
    int total = 0;
    for (var item in _items) {
      total += item.totalPrice;
    }
    return total;
  }

  bool isInCart(String itemId) {
    return _items.any((item) => item.itemId == itemId);
  }

  void addToCart({
    required String itemId,
    required String itemName,
    required int itemPrice,
    required int quantity,
    required String bakeryName,
    required String imageUrl,
  }) {
    final existingItemIndex = _items.indexWhere((item) => item.itemId == itemId);

    if (existingItemIndex >= 0) {
      _items[existingItemIndex].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          itemId: itemId,
          itemName: itemName,
          itemPrice: itemPrice,
          quantity: quantity,
          bakeryName: bakeryName,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.itemId == itemId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    final itemIndex = _items.indexWhere((item) => item.itemId == itemId);
    if (itemIndex >= 0) {
      _items[itemIndex].quantity = quantity;
      notifyListeners();
    }
  }
}