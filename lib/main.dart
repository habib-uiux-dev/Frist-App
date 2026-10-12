import 'package:flutter/material.dart';
import 'package:untitled7/Screen/ProductGridviewScreen.dart';

import 'Srceen/ProductGridviewScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter CRUD APP',
      home: const ProductGridViewScreen(),
    );
  }
}