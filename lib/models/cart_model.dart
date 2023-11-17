// models/cart_model.dart

import 'package:flutter/foundation.dart';
import 'products.dart';

class CartModel extends ChangeNotifier {
  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  double get totalPrice =>
      _cartItems.fold(0, (sum, product) => sum + product.price);

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }
}
