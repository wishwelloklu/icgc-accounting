import 'package:flutter/material.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/app_images.dart';

import '../../../app/utils/svg_icon.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final bool showClearIcon;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final Color background;
  final FocusNode? focusNode;
  final double? height;
  final void Function(String text)? onChange;
  final VoidCallback? onTap;
  final Function(PointerDownEvent event)? onTapOutside;
  const SearchTextField({
    super.key,
    this.controller,
    this.onTap,
    this.focusNode,
    this.height,
    this.labelText = '',
    this.hintText = 'Search anything',
    this.showClearIcon = false,
    this.onTapOutside,
    this.background = AppColors.pageBorder,
    this.prefixIcon = const SvgIcon(icon: AppImages.search, size: 20),
    this.suffixIcon,
    this.borderColor,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChange,
      onTapOutside: (event) {
        if (onTapOutside != null) {
          onTapOutside!(event);
        }
      },
      onTap: onTap,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        isDense: true,
        fillColor: AppColors.textInputField,
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SvgIcon(icon: AppImages.search),
        ),
        suffixIcon: suffixIcon,

        filled: true,

        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textInputFieldBorder),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textInputFieldBorder),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textInputFieldBorder),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textInputFieldBorder),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
