// screens/cart_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return cart.cartItems.isEmpty
              ? Center(
            child: Text('Your shopping cart is empty.'),
          )
              : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cart.cartItems[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                          'Price: \$${product.price.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: () {
                          Provider.of<CartModel>(context, listen: false)
                              .removeFromCart(product);
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Price: \$${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50,)
            ],
          );
        },
      ),
    );
  }
}
