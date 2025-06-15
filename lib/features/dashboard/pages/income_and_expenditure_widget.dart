import 'package:accounting_app/app/theme/style.dart';
import 'package:accounting_app/features/dashboard/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class IncomeAndExpenditureWidget extends StatefulWidget {
  const IncomeAndExpenditureWidget({super.key});

  @override
  State<IncomeAndExpenditureWidget> createState() =>
      _IncomeAndExpenditureWidgetState();
}

class _IncomeAndExpenditureWidgetState
    extends State<IncomeAndExpenditureWidget> {
  final List<String> labels = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];
  final List<double> incomeData = [
    5000,
    5200,
    4800,
    5300,
    5500,
    6000,
    5800,
    5700,
    5900,
    6100,
    6200,
    6500,
  ];
  final List<double> expenditureData = [
    4500,
    4600,
    4700,
    4800,
    4900,
    5000,
    5100,
    5200,
    5300,
    5400,
    5500,
    5600,
  ];

  final ScrollController _scrollController = ScrollController();
  bool _showRightArrow = true; // State to control arrow visibility

  @override
  void initState() {
    super.initState();
    // Listener to update arrow visibility based on scroll position
    _scrollController.addListener(() {
      setState(() {
        _showRightArrow =
            _scrollController.position.maxScrollExtent >
            _scrollController.offset;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _showRightArrow = _scrollController.position.maxScrollExtent > 0;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData = List.generate(labels.length, (index) {
      return ChartData(
        month: labels[index],
        income: incomeData[index],
        expenditure: expenditureData[index],
      );
    });
    return Container(
      padding: EdgeInsets.all(16),
      // height: size.height * .45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Income & Expenditure',
            style: appTextStyle(color: Colors.black, fontSize: 14),
          ),
          Gap(2),
          Text(
            'As of Jan 2025',
            style: appTextStyle(color: Color(0xFF475467), fontSize: 14),
          ),
          Gap(12),
          Stack(
            children: [
              NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  // Update arrow visibility during scroll
                  if (scrollNotification is ScrollUpdateNotification) {
                    setState(() {
                      _showRightArrow =
                          _scrollController.position.maxScrollExtent >
                          _scrollController.offset;
                    });
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 800,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFF9F9F9),
                      border: Border.all(color: Color(0xFFEBECEE)),
                    ),
                    child: SfCartesianChart(
                      // zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                      primaryXAxis: CategoryAxis(
                        title: AxisTitle(text: 'Month'),
                        labelStyle: TextStyle(color: Colors.black87),
                        majorGridLines: MajorGridLines(
                          width: 0.5,
                          color: Colors.grey[300],
                        ),
                        maximumLabels: 12,
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(text: 'Amount (\$)'),
                        labelStyle: TextStyle(color: Colors.black87),
                        majorGridLines: MajorGridLines(
                          width: 0.5,
                          color: Colors.grey[300],
                        ),
                        minimum: 0,
                        // labelRotation: 90,
                      ),

                      legend: Legend(
                        isVisible: true,
                        position: LegendPosition.top,
                        textStyle: TextStyle(color: Colors.black87),
                      ),
                      series: <CartesianSeries>[
                        LineSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.month,
                          yValueMapper: (ChartData data, _) => data.income,
                          name: 'Income',
                          color: Color(
                            0xFF4BC0C0,
                          ), // Same color as Chart.js example
                          width: 2,
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                        LineSeries<ChartData, String>(
                          dataSource: chartData,
                          xValueMapper: (ChartData data, _) => data.month,
                          yValueMapper: (ChartData data, _) => data.expenditure,
                          name: 'Expenditure',
                          color: Color(
                            0xFFFF6384,
                          ), // Same color as Chart.js example
                          width: 2,
                          markerSettings: MarkerSettings(isVisible: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 8,
                bottom: 5,
                child: AnimatedOpacity(
                  opacity: _showRightArrow ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 200),
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "More",
                            style: appTextStyle(color: Colors.black),
                          ),
                          Gap(5),
                          Icon(Icons.double_arrow_sharp, color: Colors.black),
                        ],
                      ),
                    ),
                    onTap: () {
                      // Scroll right when pressed
                      _scrollController.animateTo(
                        _scrollController.offset + 100,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
