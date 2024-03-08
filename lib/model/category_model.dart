import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  int quantity;
  double price;
  String imageUrl;

  Product({
    required this.name,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    return Product(
      name: doc['name'],
      quantity: doc['quantity'],
      price: doc['price'],
      imageUrl: doc['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
