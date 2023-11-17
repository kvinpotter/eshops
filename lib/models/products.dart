// models/products.dart

class Product {
  final String key;
  final String name;
  final String imageUrl;
  final double price;

  Product({
    required this.key,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}
