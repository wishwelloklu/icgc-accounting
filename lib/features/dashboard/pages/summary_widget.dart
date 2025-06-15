import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/features/dashboard/widgets/filter_modalsheet.dart';
import 'package:accounting_app/features/dashboard/widgets/summary_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Account Summary',
                      style: appTextStyle(color: Colors.black, fontSize: 14),
                    ),
                    Gap(2),
                    Text(
                      'As of Jan 2025',
                      style: appTextStyle(
                        color: Color(0xFF475467),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return FilterModalsheet(onFilter: () {});
                    },
                  );
                },
                child: Chip(
                  label: Icon(Icons.filter_list, color: AppColors.primaryColor),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  labelPadding: EdgeInsets.zero,
                  side: BorderSide(color: AppColors.primaryColor),
                  backgroundColor: AppColors.primaryColor.withValues(alpha: .1),
                ),
              ),
            ],
          ),
          Gap(12),
          SummaryTile(title: "Incoming", value: "20"),
          Gap(12),
          SummaryTile(title: "Expenditure", value: "20"),
          Gap(12),
          SummaryTile(title: "Total church asset", value: "20"),
        ],
      ),
    );
  }
}
