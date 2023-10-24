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
    final data = ref.read(weeklyDataProvider);

    if (data == null || data.isEmpty || data['gamePercentages'] == null) {
      // Handle the case where data is null or doesn't contain gamePercentages
      return const Center(
        child: Text(
          '',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                ref.watch(selectedTabProvider.notifier).setSelectedTab(0);
                return;
              }

              ref.watch(selectedTabProvider.notifier).setSelectedTab(
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
    final data = ref.read(weeklyDataProvider);
    if (data == null || data['gamePercentages'] == null) {
      return []; // Return an empty list when data is null or doesn't contain gamePercentages
    }

    return data['gamePercentages']
        .entries
        .map((entry) {
          final index = data.entries.toList().indexOf(entry);
          final isTouched = index == ref.watch(selectedTabProvider);
          final fontSize = !isTouched ? 20.0 : 16.0;
          final radius = !isTouched ? 60.0 : 50.0;
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
            ),
            badgeWidget: null,
            badgePositionPercentageOffset: .98,
          );
        })
        .toList()
        .cast<PieChartSectionData>();
  }

  Color _getColorFromName(String name) {
    switch (name.toLowerCase()) {
      case 'betting':
        return Colors.red;
      case 'coffee':
        return Colors.orange;
      case 'dstv':
        return Colors.blue;
      case 'pool':
        return Colors.green;
      case 'ps':
        return Colors.purple;
      case 'vr':
        return Colors.yellow;
      default:
        return Colors.pink;
    }
  }
}
