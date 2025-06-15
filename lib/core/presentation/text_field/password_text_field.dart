import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/style.dart';

import '../text/label_text.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? validationText;
  final String hintText;
  final bool obscureText;
  final Icon suffixIcon;

  const PasswordTextField({
    super.key,
    this.controller,
    this.validationText,
    this.labelText = '',
    this.hintText = '',
    this.obscureText = true,
    this.suffixIcon = const Icon(Icons.visibility),
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextField();
}

class _PasswordTextField extends State<PasswordTextField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabelText(text: widget.labelText),
        Gap(10),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          // height: AppPadding.buttonHeight,
          child: TextFormField(
            controller: widget.controller,

            obscureText: _isObscured,
            validator: (value) {
              // RegExp regex = RegExp(ConstantConfig.emailPattern);
              if (value == null || value.isEmpty) {
                return widget.validationText ?? "Enter your password";
              }
              //  else if (!regex.hasMatch(value)) {
              //   return "Please enter a valid email address";
              // }
              return null;
            },
            decoration: InputDecoration(
              hintText: widget.hintText,

              fillColor: AppColors.textInputField,
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              isDense: true,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: _isObscured
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),

                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : widget.suffixIcon,
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
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.redColor),
              ),
              focusColor: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
