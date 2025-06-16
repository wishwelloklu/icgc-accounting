import 'package:accounting_app/app/theme/app_colors.dart';
import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/features/dashboard/pages/income_and_expenditure_widget.dart';
import 'package:accounting_app/features/dashboard/pages/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
  
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: AppColors.primaryColor)),
          Positioned(
            top: 105,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Gap(28),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ICGC Account",
                          style: appTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Upper Room",
                          style: appTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFBDBDBD),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            top: size.height * .3,
            child: Container(
              width: size.width,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 240, 246),
                borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              ),
            ),
          ),
          Positioned.fill(
            top: size.height * .2,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12),
              // physics: NeverScrollableScrollPhysics(),
              children: [
                SummaryWidget(),
                Gap(20),
                IncomeAndExpenditureWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String month;
  final double income;
  final double expenditure;

  ChartData({
    required this.month,
    required this.income,
    required this.expenditure,
  });
}
