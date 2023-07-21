import 'package:api_blocs/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my app',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const Home(),
    );
  }
}
