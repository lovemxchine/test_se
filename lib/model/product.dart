class Product {
  final String id;
  final String name;
  final int price;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}
