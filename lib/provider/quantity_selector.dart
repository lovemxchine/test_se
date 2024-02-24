import 'package:flutter/material.dart';

class QuantitySelector extends ChangeNotifier {
  int quantity = 1;

  void quantityIncreament() {
    if (quantity < 20) {
      quantity++;
      notifyListeners();
    }
  }

  void quantityDecreament() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  bool canDecreament() => quantity > 1;
}
