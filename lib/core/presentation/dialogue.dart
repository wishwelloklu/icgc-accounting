import 'package:flutter/material.dart';

class Dialogue extends StatelessWidget {
  const Dialogue({super.key, required this.child, this.insetPadding});
  final Widget child;
  final EdgeInsets? insetPadding;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.black.withValues(alpha: .3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: insetPadding,
      child: child,
    );
  }
}
