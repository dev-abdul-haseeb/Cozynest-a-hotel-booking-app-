import 'dart:ui';
import 'package:flutter/material.dart';

TextStyle LogoHead(double headings) {
  return TextStyle(
    fontFamily: 'RobotoCondensed',
    fontWeight: FontWeight.bold,
    fontSize: headings,
    letterSpacing: 4,
  );
}

TextStyle slogan(double size) {
  return TextStyle(
    fontFamily: 'RobotSerif',
    fontSize: size,
    wordSpacing: 1,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

TextStyle bookingStyle(double screenHeight) {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: screenHeight * 0.016,
  );
}

TextStyle bookingTiles() {
  return TextStyle(color: Colors.white);
}
