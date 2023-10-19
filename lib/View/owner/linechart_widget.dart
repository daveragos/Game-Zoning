import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/date_provider.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';
import 'package:gamezoning/Controller/functions/weekly_data.dart';
import 'package:intl/intl.dart';

class LineChartWidget extends ConsumerWidget {
  LineChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabbed = ref.watch(selectedTabProvider);
    final lineData =
        ref.watch(weeklyDataProvider.notifier).state['gameGroupData'];
    final selectedDate = ref.watch(selectedDateProvider);
    //formate the date
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    if (lineData == null || lineData.isEmpty) {
      // Display a message to the user that there is no data available
      return Center(
        child: Text(
          'No data available on weekdays of $formattedSelectedDate',
          style: const TextStyle(fontSize: 20),
        ),
      );
    } else if (tabbed >= lineData.length) {
      // Handle the case where tabbed is an invalid index for the list
      return const Center(
        child: Text(
          'Invalid tab index',
          style: TextStyle(fontSize: 20),
        ),
      );
    } else {
      final data = lineData.values.toList()[tabbed];
      // Use the data variable as needed
    }
    if (lineData == null) {
      return const SizedBox();
    }

    double maxAmount = double.negativeInfinity;

    lineData.forEach((key, value) {
      for (var entry in value) {
        double amount = entry["amount"];
        if (amount > maxAmount) {
          maxAmount = amount;
        }
      }
    });
    maxAmount = ((maxAmount + 1000) / 1000).ceilToDouble() * 1000;
    print('MAX AMOUNT : $maxAmount');
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
            axisNameSize: 5,
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                TextStyle? style = const TextStyle(
                    color: Color(0xff72719b),
                    fontWeight: FontWeight.bold,
                    fontSize: 10);
                // Scale up the value by a factor of 1000 to get the original amount value
                final amount = value * 1000;
                final formatter = NumberFormat.compact();

                return Text(formatter.format(amount));
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
      final dateValue = date.weekday - 1; // Start from 0 instead of 6
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
