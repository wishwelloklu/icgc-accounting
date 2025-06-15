import 'package:flutter/material.dart';

TextStyle? appTextStyle({
  double? fontSize,
  Color? color = const Color(0xFF333333),
  FontWeight? fontWeight = FontWeight.w400,
  TextDecoration? textDecoration,
  String? fontFamily,
}) {
  return TextStyle(
    fontFamily: fontFamily ?? 'Outfit',
    height: 1.1,
    letterSpacing: 0.0,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    decoration: textDecoration,
  );
}
