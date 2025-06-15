import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/core/presentation/buttons/app_primary_button.dart';
import 'package:accounting_app/core/presentation/text/label_text.dart';
import 'package:accounting_app/core/presentation/text_field/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FilterModalsheet extends StatelessWidget {
  const FilterModalsheet({super.key, required this.onFilter});
  final void Function() onFilter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 28, right: 28, top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTextField(
            labelText: 'Filter by',
            hintText: 'Today',
            isRequired: true,
            readOnly: true,
            suffixIcon: Icon(Icons.keyboard_arrow_down),
          ),
          Gap(20),
          LabelText(text: "Filter by date"),
          Row(
            children: [
              Expanded(
                child: InputTextField(hintText: 'Start Date', readOnly: true),
              ),
              Gap(10),
              Expanded(
                child: InputTextField(hintText: 'End Date', readOnly: true),
              ),
            ],
          ),
          Gap(40),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: "Clear filter",
                  textColor: AppColors.primaryColor,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  applyBorder: true,
                  borderColor: AppColors.primaryColor,
                  radius: 100,
                ),
              ),
              Gap(12),
              Expanded(
                child: PrimaryButton(
                  text: "Filter",
                  onPressed: () {},
                  radius: 100,
                ),
              ),
            ],
          ),
          Gap(92),
        ],
      ),
    );
  }
}
