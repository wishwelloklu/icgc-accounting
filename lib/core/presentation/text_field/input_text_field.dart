import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import '../../../app/config/constant_config.dart';
import '../text/label_text.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String hintText;
  final String? Function(String? value)? validator;
  final bool isEmail;
  final bool isSuggest;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final bool isRequired;
  final Function(PointerDownEvent value)? onTapOutSide;
  final Widget? labelTrail;
  final Widget? suffixIcon;
  final bool multiLine;
  final int? maxLine;
  final bool readOnly;
  const InputTextField({
    super.key,
    this.controller,
    this.suffixIcon,
    this.onTapOutSide,
    this.labelText,
    this.hintText = '',
    this.validator,
    this.maxLine,
    this.readOnly = false,
    this.isEmail = false,
    this.isSuggest = false,
    this.isRequired = false,
    this.labelTrail,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.multiLine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (labelText != null)
          // labelText != null?
          LabelText(text: isRequired ? labelText! : '$labelText (Optional)'),
        Gap(10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: TextFormField(
            controller: controller,
            onTapOutside: onTapOutSide,
            readOnly: readOnly,
            validator: validator != null
                ? (value) => validator!(value)
                : isEmail
                ? (value) {
                    RegExp regex = RegExp(ConstantConfig.emailPattern);
                    if (value == null || value.isEmpty) {
                      return "$labelText field is required";
                    } else if (!regex.hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  }
                : isRequired
                ? (text) {
                    if (text == null || text.isEmpty) {
                      return "$labelText field is required";
                    }
                    return null;
                  }
                : null,
            maxLines: multiLine ? null : 1,
            minLines: multiLine ? 2 : null,
            enableSuggestions: isSuggest,
            keyboardType: isEmail ? TextInputType.emailAddress : textInputType,
            textCapitalization: isEmail
                ? TextCapitalization.none
                : textCapitalization,
            decoration: InputDecoration(
              hintText: hintText,
              isDense: true,
              fillColor: AppColors.textInputField,
              filled: true,
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
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
              focusColor: AppColors.tertiaryColor,
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.redColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
