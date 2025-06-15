import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/features/dashboard/widgets/green_dot.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xFFF9F9F9),
        border: Border.all(color: Color(0xFFEBECEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GreenDot(),
              Gap(4),
              Text(
                title,
                style: appTextStyle(color: Color(0xFF475467), fontSize: 12),
              ),
            ],
          ),
          Gap(20),
          Text(
            value,
            style: appTextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
