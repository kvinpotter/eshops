// product_details.dart

import 'package:flutter/material.dart';
import 'package:eshops/models/products.dart';
import 'package:provider/provider.dart';

import '../models/cart_model.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imageUrl,
              width: 200.0,
              height: 200.0,
              // You can add additional properties like fit, alignment, etc.
            ),
            SizedBox(height: 16.0),
            Text(
              product.name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description: Add your product description here.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0,),
            IconButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Cart: ${product.name}'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              color: Colors.orange, icon: Icon(Icons.shopping_cart),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
