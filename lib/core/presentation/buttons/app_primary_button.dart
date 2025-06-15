import 'package:flutter/material.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double height;
  final Color backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool showLoadingIndicator;
  final double radius;
  final bool applyBorder;
  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.borderColor,
    this.height = 40,
    this.radius = 10,
    this.width,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor,
    this.showLoadingIndicator = false,
    this.applyBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: appTextStyle(),
          foregroundColor: textColor ?? AppColors.whiteColor,
          disabledBackgroundColor: backgroundColor.withValues(alpha: .4),
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: applyBorder
                ? BorderSide(color: borderColor ?? Colors.transparent)
                : BorderSide.none,
          ),
        ),
        onPressed: showLoadingIndicator ? null : onPressed,
        child: showLoadingIndicator
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator.adaptive(strokeWidth: 2),
              )
            : Text(
                text,
                style: appTextStyle(
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.whiteColor,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
