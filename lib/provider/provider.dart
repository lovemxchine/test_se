import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_se/model/product.dart';

class CartProvider extends ChangeNotifier {
  static const String _cartKey = 'cart';

  List<Product> _items = [];
  List<Product> get items => _items;
  Future<void> fetchCartFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cartJson = prefs.getString(_cartKey);
    if (cartJson != null) {
      final List<dynamic> jsonList = jsonDecode(cartJson);
      _items = jsonList.map((json) => Product.fromJson(json)).toList();
    }
  }

  Future<void> saveCartToSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cartJson =
        jsonEncode(_items.map((item) => item.toJson()).toList());
    prefs.setString(_cartKey, cartJson);
  }

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
    saveCartToSharedPref();
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
    saveCartToSharedPref();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    saveCartToSharedPref();
    notifyListeners();
  }

  int getTotalPrice() {
    int total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

class ConfirmCart extends ChangeNotifier {
  static const String _confirmCartKey = 'confirm_cart';

  List<Product> _items = [];

  List<Product> get items => _items;

  Future<void> fetchConfirmCartFromSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? confirmCartJson = prefs.getString(_confirmCartKey);
    if (confirmCartJson != null) {
      final List<dynamic> jsonList = jsonDecode(confirmCartJson);
      _items = jsonList.map((json) => Product.fromJson(json)).toList();
    }
  }

  Future<void> saveConfirmCartToSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String confirmCartJson =
        jsonEncode(_items.map((item) => item.toJson()).toList());
    prefs.setString(_confirmCartKey, confirmCartJson);
  }

  void confirmOrder(BuildContext context) {
    List<Product> cartItems =
        Provider.of<CartProvider>(context, listen: false).items;

    for (var cartItem in cartItems) {
      bool isExist = false;
      for (var item in _items) {
        if (item.id == cartItem.id) {
          item.quantity += cartItem.quantity;
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        _items.add(cartItem);
      }
    }
    saveConfirmCartToSharedPref();
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    saveConfirmCartToSharedPref();
    notifyListeners();
  }

  int getTotalPrice() {
    int total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
