// checkout_page.dart

import 'dart:convert';
import 'package:eshops/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cart.cartItems[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(
                          'Price: \Tshs ${product.price.toStringAsFixed(2)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Price: \Tshs ${cart.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Details:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(labelText: 'Address'),
                    ),
                    TextFormField(
                      controller: _paymentController,
                      decoration:
                      InputDecoration(labelText: 'Payment Details'),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String userName = _nameController.text;
                    String userAddress = _addressController.text;
                    String paymentDetails = _paymentController.text;

                    // Convert the list of cart items to a JSON string
                    String orderItems = jsonEncode(cart.cartItems);

                    // Send the order information to the PHP script
                    var response = await http.post(
                      Uri.parse('http://192.168.100.44/order.php'),
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({
                        'userName': userName,
                        'userAddress': userAddress,
                        'paymentDetails': paymentDetails,
                        'orderItems': orderItems,
                      }),
                    );

                    // Check the response from the server
                    if (response.statusCode == 200) {
                      // Order placed successfully
                      print(response.body);

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Order placed successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );

                      // Optionally, you can navigate to a confirmation page
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                    } else {
                      // Error placing order
                      print('Error placing order: ${response.body}');

                      // Show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error placing order'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('Proceed to Checkout'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
