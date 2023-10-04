
/*
Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: SizedBox(
                height: 300,
                width: 400,
                child: LineChartWidget(
                    dummyData1: dummyData1,
                    dummyData2: dummyData2,
                    dummyData3: dummyData3),
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 200, height: 200, child: WeeklyPiePage()),
                Column(
                  children: [
                    Text(
                      'Game Name',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                    Text('Mon: 7213'),
                    Text('Tue: 7213'),
                    Text('Wed: 7213'),
                    Text('Thu: 7213'),
                    Text('Fri: 7213'),
                    Text('Sat: 7213'),
                    Text(
                      'Sun: 7213',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text(
                      'Total: 7213',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),*/












// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class WeeklyPiePage extends ConsumerStatefulWidget {
//   const WeeklyPiePage({required this.selectedSection, super.key});
//   int selectedSection;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _WeeklyPiePageState();
// }

// class _WeeklyPiePageState extends ConsumerState<WeeklyPiePage> {
//   int touchedIndex = -1;
//   @override
//   Widget build(BuildContext context) {
//     return PieChart(
//       PieChartData(
//         centerSpaceRadius: 50,
//         pieTouchData: PieTouchData(
//           touchCallback: (FlTouchEvent event, pieTouchResponse) {
//             setState(() {
//               if (!event.isInterestedForInteractions ||
//                   pieTouchResponse == null ||
//                   pieTouchResponse.touchedSection == null) {
//                 touchedIndex = -1;
//                 return;
//               }
//               touchedIndex =
//                   pieTouchResponse.touchedSection!.touchedSectionIndex;
//             });
//           },
//         ),
//         sections: [
//           PieChartSectionData(
//             value: 20,
//             color: Colors.amber,
//           ),
//           PieChartSectionData(
//             value: 40,
//             color: Colors.red,
//           ),
//           PieChartSectionData(
//             value: 50,
//             color: Colors.green,
//           ),
//           PieChartSectionData(
//             value: 60,
//             color: Colors.blue,
//           ),
//           PieChartSectionData(
//             value: 0,
//             color: Colors.yellow,
//           ),
//         ],
//       ),
//       swapAnimationDuration: const Duration(milliseconds: 150),
//       swapAnimationCurve: Curves.linear,
//     );
//   }
// }
