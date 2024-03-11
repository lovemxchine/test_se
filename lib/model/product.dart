class Product {
  final int id;
  final String name;
  final double price;
  // final String imageUrl;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    // required this.imageUrl,
    this.quantity = 1,
  });
}
