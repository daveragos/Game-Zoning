import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IndividualLineTabPage extends ConsumerStatefulWidget {
  const IndividualLineTabPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndividualLineTabPageState();
}

class _IndividualLineTabPageState extends ConsumerState<IndividualLineTabPage> {
// Generate some dummy data for the cahrt
  // This will be used to draw the red line
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 300,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: LineChart(
              LineChartData(
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  // The red line
                  LineChartBarData(
                    spots: dummyData1,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.indigo,
                  ),
                  // The orange line
                  LineChartBarData(
                    spots: dummyData2,
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.red,
                  ),
                  // The blue line
                  LineChartBarData(
                    spots: dummyData3,
                    isCurved: false,
                    barWidth: 3,
                    color: Colors.blue,
                  )
                ],
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
                              'Sun',
                              style: style,
                            );
                          case 1:
                            return Text(
                              'Mon',
                              style: style,
                            );
                          case 2:
                            return Text(
                              'Tue',
                              style: style,
                            );
                          case 3:
                            return Text(
                              'Wed',
                              style: style,
                            );
                          case 4:
                            return Text(
                              'Thru',
                              style: style,
                            );
                          case 5:
                            return Text(
                              'Fri',
                              style: style,
                            );
                          case 6:
                            return Text(
                              'Sat',
                              style: style,
                            );
                          case 7:
                            return const Text('');
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        var style = const TextStyle(
                          color: Color(0xff75729e),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        );

                        switch (value.toInt()) {
                          case 0:
                            return Text(
                              '0k',
                              style: style,
                            );
                          case 1:
                            return Text(
                              '1k',
                              style: style,
                            );
                          case 2:
                            return Text(
                              '2k',
                              style: style,
                            );
                          case 3:
                            return Text(
                              '3k',
                              style: style,
                            );
                          case 4:
                            return Text(
                              '4k',
                              style: style,
                            );
                          case 5:
                            return Text(
                              '5k',
                              style: style,
                            );
                          case 6:
                            return Text(
                              '6k',
                              style: style,
                            );
                          case 7:
                            return Text(
                              '7k',
                              style: style,
                            );
                        }
                        return const Text('');
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
            ),
          ),
        ),
      ),
    );
  }
}
