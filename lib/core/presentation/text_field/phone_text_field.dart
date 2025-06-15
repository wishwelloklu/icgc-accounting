// import 'package:flutter/material.dart';
// import '../../../app/theme/app_color.dart';
// import '../../../app/theme/app_padding.dart';
// import '../../../app/theme/app_spacer.dart';
// import '../../../app/theme/app_text_style.dart';

// import '../text/label_text.dart';

// class PhoneTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String labelText;
//   final String hintText;

//   final bool isRequired;
//   final String? Function(String? value)? validator;
//   const PhoneTextField({
//     super.key,
//     required this.controller,
//     this.isRequired = true,
//     this.labelText = '',
//     this.hintText = '',
//     this.validator,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         LabelText(
//           text: labelText,
//         ),
//         AppSpacer.verticalSpace(height: AppPadding.extraSmall),
//         SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: TextFormField(
//             controller: controller,
//             keyboardType: const TextInputType.numberWithOptions(),
//             style: AppTextStyle.appInputText(),
//             onChanged: (value) {},
//             validator: validator != null
//                 ? (value) => validator!(value)
//                 : isRequired
//                     ? (value) {
//                         if (value == null || value.isEmpty) {
//                           return "$labelText field is required";
//                         }
//                         if (value.length < 8 || value.length > 15) {
//                           return "$labelText is invalid";
//                         }
//                         return null;
//                       }
//                     : null,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: AppTextStyle.appInputHint(),
//               fillColor: AppColor.textInputField,
//               filled: true,
//               border: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.textInputFieldBorder),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppPadding.textFieldRadius),
//                 ),
//               ),
//               focusedBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.textInputFieldBorder),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppPadding.textFieldRadius),
//                 ),
//               ),
//               disabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.textInputFieldBorder),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppPadding.textFieldRadius),
//                 ),
//               ),
//               enabledBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.textInputFieldBorder),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppPadding.textFieldRadius),
//                 ),
//               ),
//               errorBorder: const OutlineInputBorder(
//                 borderSide: BorderSide(color: AppColor.redColor),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(AppPadding.textFieldRadius),
//                 ),
//               ),
//               focusColor: AppColor.tertiaryColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
