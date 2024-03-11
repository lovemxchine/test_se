import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_se/model/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items => _items;

  void addToCart(Product product) {
    if (_items.isNotEmpty) {
      bool isProductExist = false;
      for (var item in _items) {
        if (item.id == product.id) {
          item.quantity++;
          isProductExist = true;
          break;
        }
      }

      if (!isProductExist) {
        product.quantity = 1;
        _items.add(product);
      }
    } else {
      product.quantity = 1;
      _items.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    for (var item in _items) {
      if (item.id == product.id) {
        if (item.quantity > 1) {
          item.quantity--;
        } else {
          _items.remove(item);
        }
        break;
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
