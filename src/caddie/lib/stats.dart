import 'package:caddie/widgets/app_bar_widget.dart';
import 'package:caddie/widgets/stats_widget.dart';
import 'package:flutter/material.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            AppBarWidget(),
            StatsWidget()
          ],
        ),
        )
      );
  }
}