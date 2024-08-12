import 'dart:ui';
import 'package:fashion_project/model/cardview_model.dart';
import 'package:flutter/foundation.dart';

class CartModel with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(ProductModel product, String selectedSize, Color selectedColor) {
    _cartItems.add({
      'product': product,
      'quantity': 1,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    });
    notifyListeners();
  }

  void removeItem(ProductModel product) {
    _cartItems.removeWhere((item) => item['product'] == product);
    notifyListeners();
  }

  void incrementQuantity(ProductModel product) {
    for (var item in _cartItems) {
      if (item['product'] == product) {
        item['quantity']++;
        break;
      }
    }
    notifyListeners();
  }

  void decrementQuantity(ProductModel product) {
    for (var item in _cartItems) {
      if (item['product'] == product && item['quantity'] > 1) {
        item['quantity']--;
        break;
      }
    }
    notifyListeners();
  }

  void applyPromoCode(String promoCode) {}
}
