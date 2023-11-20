// models/products.dart

class Product {
  final String key;
  final String name;
  final String description;
  final double price;

  Product({
    required this.key,
    required this.name,
    required this.description,
    required this.price,

  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      key: json['product_id'],
      name: json['product_name'],
      description: json['product_description'] ?? '',
      price: double.tryParse(json['product_price'].toString()) ?? 0.0,
    );
  }
}
