import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeeklyPiePage extends ConsumerStatefulWidget {
  WeeklyPiePage({required this.selectedSection, super.key});
  int selectedSection;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeeklyPiePageState();
}

class _WeeklyPiePageState extends ConsumerState<WeeklyPiePage> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        centerSpaceRadius: 50,
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        sections: [
          PieChartSectionData(
            value: 20,
            color: Colors.amber,
          ),
          PieChartSectionData(
            value: 40,
            color: Colors.red,
          ),
          PieChartSectionData(
            value: 50,
            color: Colors.green,
          ),
          PieChartSectionData(
            value: 60,
            color: Colors.blue,
          ),
          PieChartSectionData(
            value: 0,
            color: Colors.yellow,
          ),
        ],
      ),
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
    );
  }
}
