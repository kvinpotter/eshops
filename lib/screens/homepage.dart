import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/cart.dart';
import '../components/checkout.dart';
import '../components/product.dart';
import '../models/products.dart';
import '../models/cart_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  static List<Product> _generateDummyProducts() {
    return List.generate(
      10,
          (index) => Product(
        key: 'product_$index',
        name: 'Product ${index + 1}',
        imageUrl: 'https://placekitten.com/50/50',
        price: 19.99,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? ProductList(
        products: _generateDummyProducts(),
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
}
