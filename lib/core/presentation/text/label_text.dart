import 'package:flutter/material.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/style.dart';

class LabelText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int maxLine;
  final TextAlign textAlign;
  final double? width;

  const LabelText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.color = AppColors.labelColor,
    this.maxLine = 10,
    this.width,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      child: Text(
        text,
        maxLines: maxLine,
        textAlign: textAlign,
        style: appTextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
