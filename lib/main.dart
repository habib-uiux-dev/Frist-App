import 'package:flutter/material.dart';
import 'package:untitled7/Scrceen/ProductGridviewScreen.dart';

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
      home: const ProductGridviewScreen(),
    );
  }
}