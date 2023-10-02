import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/tab_provider.dart';

class LineChartWidget extends ConsumerWidget {
  const LineChartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabbed = ref.watch(selectedTabProvider);
    return LineChart(
      LineChartData(
        minX: 0,
        minY: 0,
        maxX: 6,
        maxY: 6,
        borderData: FlBorderData(show: false),
        lineBarsData: linebarsdata(tabbed),
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
      duration: const Duration(milliseconds: 150),
      curve: Curves.ease,
    );
  }

  List<LineChartBarData> linebarsdata(int tabbed) {
    switch (tabbed) {
      case 0:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 1),
              FlSpot(2, 4),
              FlSpot(3, 2),
              FlSpot(4, 5),
              FlSpot(5, 3),
              FlSpot(6, 4),
            ],
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      case 1:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1),
              FlSpot(1, 2),
              FlSpot(2, 1),
              FlSpot(3, 3),
              FlSpot(4, 4),
              FlSpot(5, 2),
              FlSpot(6, 3),
            ],
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      case 2:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 2),
              FlSpot(1, 3),
              FlSpot(2, 2),
              FlSpot(3, 4),
              FlSpot(4, 5),
              FlSpot(5, 3),
              FlSpot(6, 4),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      case 3:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 3),
              FlSpot(3, 5),
              FlSpot(4, 6),
              FlSpot(5, 4),
              FlSpot(6, 5),
            ],
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      case 4:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 4),
              FlSpot(1, 5),
              FlSpot(2, 4),
              FlSpot(3, 6),
              FlSpot(4, 3),
              FlSpot(5, 5),
              FlSpot(6, 2),
            ],
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      case 5:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 5),
              FlSpot(1, 6),
              FlSpot(2, 5),
              FlSpot(3, 3),
              FlSpot(4, 2),
              FlSpot(5, 4),
              FlSpot(6, 3),
            ],
            isCurved: true,
            color: Colors.yellow,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      case 6:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 6),
              FlSpot(1, 7),
              FlSpot(2, 6),
              FlSpot(3, 8),
              FlSpot(4, 9),
              FlSpot(5, 7),
              FlSpot(6, 8),
            ],
            isCurved: true,
            color: Colors.pink,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
      default:
        return [
          LineChartBarData(
            spots: const [
              FlSpot(0, 0),
              FlSpot(1, 1),
              FlSpot(2, 2),
              FlSpot(3, 3),
              FlSpot(4, 4),
              FlSpot(5, 5),
              FlSpot(6, 6),
            ],
            isCurved: true,
            color: Colors.pink,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
          )
        ];
    }
  }
}
