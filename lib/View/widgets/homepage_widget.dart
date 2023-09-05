// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late SharedPreferences preferences;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  SizedBox(width: 10),
                  _buildInfoContainer(preferences
                          .containsKey(AppConstants.STORAGE_USER_PROFILE_TOKEN)
                      ? 'token = ${preferences.getString(AppConstants.STORAGE_USER_PROFILE_TOKEN).toString()}'
                      : 'we dont serve that here'),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 260,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                          barTouchData: BarTouchData(enabled: true),
                          titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    var style = TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold);
                                    switch (value.toInt()) {
                                      case 0:
                                        return Text(
                                          'Betting',
                                          style: style,
                                        );
                                      case 1:
                                        return Text(
                                          'Coffee',
                                          style: style,
                                        );
                                      case 2:
                                        return Text(
                                          'DSTV',
                                          style: style,
                                        );
                                      case 3:
                                        return Text(
                                          'Pool',
                                          style: style,
                                        );
                                      case 4:
                                        return Text(
                                          'PS',
                                          style: style,
                                        );
                                      case 5:
                                        return Text(
                                          'VR',
                                          style: style,
                                        );
                                      default:
                                        return Text('');
                                    }
                                  },
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: false,
                                ),
                              ),
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false))),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: [
                            _buildBarGroupData(0, 8, Colors.green),
                            _buildBarGroupData(1, 10, Colors.green),
                            _buildBarGroupData(2, 14, Colors.green),
                            _buildBarGroupData(3, 15, Colors.green),
                            _buildBarGroupData(4, 12, Colors.green),
                            _buildBarGroupData(5, 10, Colors.green),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              _pickDate;
                            },
                            child: Text('Pick Date')),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }

  dynamic get _pickDate => {
        showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
      };

  Container _buildInfoContainer(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[500],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      child: Column(
        children: [
          Text(
            'Total Income : 47132.32',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroupData(double x, double y, Color color) {
    return BarChartGroupData(
      x: x.toInt(),
      barRods: [
        BarChartRodData(
            toY: y,
            color: color,
            width: 30,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: 20,
              color: Colors.grey[400],
            ),
            borderRadius: BorderRadius.circular(8)),
      ],
    );
  }
}
