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
  // Add toJson method to convert Product to a JSON-encodable map
  Map<String, dynamic> toJson() {
    return {
      'product_id': key,
      'product_name': name,
      'product_description': description,
      'product_price': price,
    };
  }
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      key: json['product_id'],
      name: json['product_name'],
      description: json['product_description'] ?? '',
      price: double.tryParse(json['product_price'].toString()) ?? 0.0,
    );
  }
}
