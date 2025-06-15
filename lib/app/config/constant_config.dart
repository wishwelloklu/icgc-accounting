import 'package:flutter/material.dart';

@immutable
class ConstantConfig {
  //App Namae
  static const String appName = 'ICGC MINISTRY APP';

  //FontFamily
  static const String mulish = 'Mulish';
  static const String satoshi = 'Satoshi';
  static const String playfairDisplay = 'Playfair Display';
  static const passwordPattern =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
}
