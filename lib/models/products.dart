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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      key: json['product_id'],
      name: json['prduct_name'],
      imageUrl: json['product_image'],
      price: json['price'].toDouble(),
    );
  }
}
