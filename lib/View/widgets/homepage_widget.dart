// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/date_provider.dart';
import 'package:gamezoning/Controller/functions/incomes.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late SharedPreferences preferences;
  late String selectedEmployee;
  bool isLoading = false;
//getting the selected date from the statenotifier provider
  //

  DateTime? selectedDate;

  double totalIncome = 0.0; // Initialize to 0
  List<Map<String, dynamic>> gameDataList = [];
  @override
  void initState() {
    super.initState();

    selectedDate = ref.read(selectedDateProvider);
    getUserData(selectedDate: selectedDate);
  }

  void getUserData({required selectedDate}) async {
    setState(() {
      isLoading = true;
    });
    preferences = await SharedPreferences.getInstance();
    selectedEmployee = '';
    //format the selectedDate to yyyy-mm-dd
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate!);
    print('formatted date iiiiiiissssssssss: $formattedSelectedDate');
    var responseData = await Income().getIncomeDataByEmployeeAndDate(
        date: formattedSelectedDate, context: context);

// Response data is already parsed as a Map
    Map<String, dynamic> jsonResponse = responseData;

// Now you can access and process the data as needed
    Map<String, double> dataMap = jsonResponse['data'];
    List<Map<String, dynamic>> gameDataListApi = dataMap.entries.map((entry) {
      return {
        'game_name': entry.key,
        'amount': entry.value,
      };
    }).toList();
    print('odododo $gameDataListApi');
    gameDataList = gameDataListApi;

    // Calculate the total income
    calculateTotalIncome();

    selectedEmployee = preferences
        .getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : LiquidPullToRefresh(
              height: 225,
              color: Colors.green,
              showChildOpacityTransition: false,
              borderWidth: 2,
              onRefresh: () async {
                // 0911122465
                //await for 2 seconds
                await Future.delayed(Duration(seconds: 1));
                getUserData(selectedDate: ref.watch(selectedDateProvider));
                isLoading = false;
              },
              child: ListView(
                children: [
                  SizedBox(width: 10),
                  _buildInfoContainer(preferences
                          .containsKey(AppConstants.STORAGE_USER_PROFILE_TOKEN)
                      ? 'Employee = $selectedEmployee'
                      : 'we dont serve that here'),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 260,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: _calculateMaxAmount(),
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
                            _buildBarGroupData(0, Colors.green),
                            _buildBarGroupData(1, Colors.green),
                            _buildBarGroupData(2, Colors.green),
                            _buildBarGroupData(3, Colors.green),
                            _buildBarGroupData(4, Colors.green),
                            _buildBarGroupData(5, Colors.green),
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
                              _openDatePicker();
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

  void _openDatePicker() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: ref.watch(selectedDateProvider),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      ref.watch(selectedDateProvider.notifier).setDate(selectedDate);
      getUserData(selectedDate: ref.watch(selectedDateProvider));
      // Handle the selected date, e.g., update your UI or make an API call
      // var responseData = await Income().getIncomeDataByEmployeeAndDate(
      //     employeeUserName: "employee3name", date: selectedDate.toString());
      // print(responseData);
      // gameDataList = responseData;
      // // Calculate the total income
      // calculateTotalIncome();
    }
  }

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
            'Total Income :  ${totalIncome.toStringAsFixed(2)}',
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

  BarChartGroupData _buildBarGroupData(int index, Color color) {
    if (index >= gameDataList.length) {
      return BarChartGroupData(x: index, barRods: []);
    }

    final gameData = gameDataList[index];
    final maxYValue = _calculateMaxAmount();

    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: gameData['amount'], // Use the "amount" value from gameData
          color: color,
          width: 30,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: (gameData['amount'] != 0 || gameData['amount'] != null)
                ? maxYValue
                : 2500, // Set y to maxYValue
            color: Colors.grey[400],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ],
    );
  }

  double _calculateMaxAmount() {
    double maxAmount = 0.0;

    for (final gameData in gameDataList) {
      final amount = gameData['amount'];
      if (amount > maxAmount) {
        maxAmount = amount;
      }
    }

    // Add some padding to the maxAmount value for better visualization
    // You can adjust the padding as needed
    return maxAmount * 1.1;
  }

  // Function to calculate the total income
  void calculateTotalIncome() {
    double income = 0.0;

    for (final gameData in gameDataList) {
      income += gameData['amount'];
    }

    setState(() {
      totalIncome = income;
    });
  }
}
