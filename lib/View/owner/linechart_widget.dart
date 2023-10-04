import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';

class LineChartWidget extends ConsumerWidget {
  LineChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabbed = ref.watch(selectedTabProvider);
    final lineData =
        ref.watch(weeklyDataProvider.notifier).state['gameGroupData'];
    if (lineData == null) {
      return const SizedBox();
    }
    print(lineData); // Print the type of lineData
    Map<String, dynamic> parseData(String data) {
      // Remove the curly braces at the beginning and end to get valid JSON
      String jsonString = data.substring(1, data.length - 1);
      jsonString = jsonString.replaceAll("}, {", "},\n{");

      return json.decode("{$jsonString}");
    }

    String maxKey;
    double maxAmount = double.negativeInfinity;

    lineData.forEach((key, value) {
      for (var entry in value) {
        double amount = entry["amount"];
        if (amount > maxAmount) {
          maxAmount = amount;
          maxKey = key;
        }
      }
    });
    return LineChart(
      LineChartData(
        minX: 0,
        minY: 0,
        maxX: 6,
        maxY: maxAmount / 1000, // Scale down the maxY value by a factor of 1000
        borderData: FlBorderData(show: false),
        lineBarsData: linebarsdata(tabbed: tabbed, lineData: lineData),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                TextStyle? style = const TextStyle(
                    color: Color(0xff72719b),
                    fontWeight: FontWeight.bold,
                    fontSize: 16);

                switch (value.toInt()) {
                  case 0:
                    return Text(
                      'Mon',
                      style: style,
                    );
                  case 1:
                    return Text(
                      'Tue',
                      style: style,
                    );
                  case 2:
                    return Text(
                      'Wed',
                      style: style,
                    );
                  case 3:
                    return Text(
                      'Thu',
                      style: style,
                    );
                  case 4:
                    return Text(
                      'Fri',
                      style: style,
                    );
                  case 5:
                    return Text(
                      'Sat',
                      style: style,
                    );
                  case 6:
                    return Text(
                      'Sun',
                      style: style,
                    );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                TextStyle? style = const TextStyle(
                    color: Color(0xff72719b),
                    fontWeight: FontWeight.bold,
                    fontSize: 10);
                // Scale up the value by a factor of 1000 to get the original amount value
                final amount = value * 1000;

                return Text(amount.toInt().toString() + 'k');
              },
              reservedSize: 28,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
      duration: const Duration(milliseconds: 150),
      curve: Curves.ease,
    );
  }

  List<LineChartBarData> linebarsdata(
      {required int tabbed, required lineData}) {
    final data = lineData.values.toList()[tabbed];
    final spots = data.map((d) {
      final date = DateTime.parse(d['date']);
      final dateValue = date.weekday - 1;
      final amount =
          d['amount'] / 1000; // Scale down the amount by a factor of 1000
      return FlSpot(dateValue.toDouble(), amount);
    }).toList();

    return [
      LineChartBarData(
        spots: spots.cast<FlSpot>(),
        isCurved: true,
        color: _colors[tabbed % _colors.length],
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
      )
    ];
  }

  final _colors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.yellow,
    Colors.pink,
  ];
}
