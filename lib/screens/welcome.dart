import 'package:eshops/screens/homepage.dart';
import 'package:flutter/material.dart';

import '../components/button.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart,
            size: 80,
            color: Colors.blueAccent,),
            const SizedBox(height: 20,),
            const Text('Online Shop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),),
            const SizedBox(height: 10,),
            const Text('Shop now for best products',
            style: TextStyle(color: Colors.grey),),
           const SizedBox(height: 20,) ,
           MyButton(onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));},
               child: const Text('Shop Now',
             style: TextStyle(
                 color: Colors.white,),))
          ],
        ),
      )
    );
  }
}

