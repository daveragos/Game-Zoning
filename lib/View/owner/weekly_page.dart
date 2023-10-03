import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';

class PieChartSample2 extends ConsumerStatefulWidget {
  const PieChartSample2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PieChart2State();
}

class _PieChart2State extends ConsumerState<PieChartSample2> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                ref.read(selectedTabProvider.notifier).setSelectedTab(-1);
                return;
              }
              ref.read(selectedTabProvider.notifier).setSelectedTab(
                  pieTouchResponse.touchedSection!.touchedSectionIndex);
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: showingSections(),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    var weeklyData =
        ref.read(weeklyDataProvider.notifier).state['gamePercentages'];
    print(weeklyData);
    return weeklyData.entries
        .map((entry) {
          final index = weeklyData.entries.toList().indexOf(entry);
          final isTouched = index == ref.watch(selectedTabProvider);
          final fontSize = isTouched ? 20.0 : 16.0;
          final radius = isTouched ? 60.0 : 50.0;
          const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
          final value = double.parse(entry.value.toStringAsFixed(2));
          final color = _getColorFromName(entry.key);
          return PieChartSectionData(
            color: color,
            value: value,
            title: '${value.toString()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: null,
            badgePositionPercentageOffset: .98,
          );
        })
        .toList()
        .cast<PieChartSectionData>();
  }

  Color _getColorFromName(String name) {
    switch (name) {
      case 'Betting':
        return Colors.green;
      case 'DSTV':
        return Colors.blue;
      case 'Coffee':
        return Colors.yellow;
      case 'Pool':
        return Colors.red;
      case 'PS':
        return Colors.purple;
      case 'VR':
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}
