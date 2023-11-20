import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eshops/models/products.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  ProductDetailsPage({required this.productId, required Product product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Product _product = Product(
    key: 'default',
    name: 'Default Product',
    price: 0.0,
    description: '',
  );

  @override
  void initState() {
    super.initState();
    // Load product details when the widget is initialized
    _loadProductDetails();
  }

  Future<void> _loadProductDetails() async {
    final apiUrl = 'http://192.168.100.44/product_details.php?productId=${widget.productId}';


    try {
      print('Fetching product details from: $apiUrl');
      print('Product ID: ${widget.productId}');

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> data = json.decode(response.body);
          setState(() {
            // Create a Product object from the fetched data
            _product = Product(
              key: data['product_id'],
              name: data['product_name'],
              price: double.parse(data['product_price'].toString()),
              description: data['product_description'] ?? '',
            );
          });
        } else {
          print('Empty response body');
        }
      } else {
        print('Failed to load product details. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error loading product details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: _product != null
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              _product.name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${_product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: ${_product.description.isNotEmpty ? _product.description : 'No description available'}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            IconButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).addToCart(_product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Cart: ${_product.name}'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              color: Colors.orange,
              icon: Icon(Icons.shopping_cart),
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
