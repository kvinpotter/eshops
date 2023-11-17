import 'package:eshops/screens/homepage.dart';
import 'package:eshops/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart_model.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: MaterialApp(
      home: WelcomePage(),
    ),
  ));
}

