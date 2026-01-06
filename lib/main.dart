import 'package:flutter/material.dart';
import 'package:hotel_booking/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'RobotoSerif',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green.shade200),
      ),
      home: splashScreeen(),
    );
  }
}