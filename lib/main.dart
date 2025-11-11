import 'package:flutter/material.dart';
import 'package:football_shop_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Shop',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF1976D2), 
          secondary: Color(0xFF2196F3),
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
