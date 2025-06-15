import 'package:flutter/material.dart';

class AppAnimatedWidget extends StatelessWidget {
  const AppAnimatedWidget(
      {super.key,
      required this.child,
      this.opacity,
      this.duration,
      this.curve});
  final Widget? child;
  final double? opacity;
  final Duration? duration;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: opacity ?? 1,
        duration: duration ?? const Duration(milliseconds: 200),
        child: AnimatedSize(
          duration: duration ?? const Duration(milliseconds: 200),
          curve: curve ?? Curves.easeInOut,
          child: child,
        ));
  }
}
