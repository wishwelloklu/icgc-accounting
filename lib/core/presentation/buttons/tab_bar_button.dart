import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton(
      {super.key, required this.text, this.color, required this.isSelected});
  final String text;
  final Color? color;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).floatingActionButtonTheme.backgroundColor;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected ? color : null,
      ),
      child: Tab(text: text),
    );
  }
}
