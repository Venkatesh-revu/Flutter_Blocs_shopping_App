import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Image.asset('assets/images/order_placed.png'),
          // Image.asset('assets/images/order_placed2.'),
          const Text(
            "Order Placed Successfully!",
            style: TextStyle(
                color: Colors.orange,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
