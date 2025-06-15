import 'package:flutter/material.dart';
import 'package:accounting_app/app/theme/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: const Icon(
        Icons.chevron_left,
        size: 30.0,
        color: AppColors.darkColor,
      ),
    );
  }
}
