import 'package:flutter/material.dart';

class GreenDot extends StatelessWidget {
  const GreenDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF19B36E),
      ),
    );
  }
}
