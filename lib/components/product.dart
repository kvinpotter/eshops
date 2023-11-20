// components/product_list.dart

import 'package:eshops/components/product_details.dart';
import 'package:flutter/material.dart';
import '../models/products.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(product: product, productId: product.key,),
                ),
              );
            },

            title: Text(product.name),
            subtitle: Text('Price: \Tshs ${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              onPressed: () {
                Provider.of<CartModel>(context, listen: false).addToCart(product);
              },
              icon: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
