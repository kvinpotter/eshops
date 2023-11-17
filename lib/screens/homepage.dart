import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eshops/components/cart.dart';
import 'package:eshops/components/checkout.dart';
import 'package:eshops/components/product.dart'; // Import the modified ProductList widget
import 'package:eshops/models/cart_model.dart';
import 'package:eshops/models/products.dart';
import 'package:http/http.dart' as http;// Import the Product model

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? FutureBuilder<List<Product>>(
        
        future: fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ProductList(products: snapshot.data!);
          }
        },
      )
          : CartPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 1
          ? FloatingActionButton.extended(
        onPressed: () {
          // Navigate to the checkout page when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(),
            ),
          );
        },
        label: Text('Checkout'),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<List<Product>> fetchProducts() async {
    // Replace the URL with your actual server endpoint
    final response = await http.get(Uri.parse('https://your-server-endpoint/load_products.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Product> fetchedProducts = data.map((item) => Product.fromJson(item)).toList();
      return fetchedProducts;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
