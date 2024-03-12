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

  int getTotalPrice() {
    int total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
}

class ConfirmCart extends ChangeNotifier {
  List<Product> _items = [];
  // BuildContext _context;

  // ConfirmCart(this._context);

  List<Product> get items => _items;

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
  }

  void clearCart() {
    _items.clear();
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
