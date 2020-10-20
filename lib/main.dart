import 'package:distrimqtt/src/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distribuidos',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}