import 'package:flutter/material.dart';

class TabBarPage extends StatelessWidget {
  const TabBarPage({
    super.key,
    required TabController tabController,
    required this.pages,
  }) : _tabController = tabController;

  final TabController _tabController;
  final List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: _tabController,
      children: pages,
    );
  }
}
