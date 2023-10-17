// ignore_for_file: use_build_context_synchronously

import 'package:gamezoning/Controller/Constants/https_route_consts.dart';
import 'package:gamezoning/Model/api.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Income {
  SharedPreferences? pref;

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  //function for getting income data with employee
  Future<dynamic> getIncomeDataByEmployee(BuildContext context) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_EMPLOYEES,
      data: {'employee_username': selectedEmployee},
    );
    return result;
  }

  //function for getting income data with employee and date
  Future<dynamic> getIncomeDataByEmployeeAndDate(
      {required BuildContext context, required String date}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_DATE,
      data: {
        'employee_username': selectedEmployee,
        'date': date,
      },
    );
    //check all possible response types and return accordingly
    return result;
  }

  //function for getting income data with employee and game
  Future<dynamic> getIncomeDataByEmployeeAndGame(
      {required BuildContext context, required String gameName}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_GAME,
      data: {
        'employee_username': selectedEmployee,
        'game_name': gameName,
      },
    );
    return result;
  }

  //function for getting income data with employee and game and date
  Future<dynamic> getIncomeDataByEmployeeAndGameAndDate(
      {required BuildContext context,
      required String gameName,
      required String date}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_DATE_AND_GAME,
      data: {
        'employee_username': selectedEmployee,
        'game_name': gameName,
        'date': date,
      },
    );
    return result;
  }

  //function for getting income data with employee and date range
  Future<dynamic> getIncomeDataByEmployeeAndDateRange(
      {required BuildContext context,
      required String startDate,
      required String endDate}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_DATE_RANGE,
      data: {
        'employee_username': selectedEmployee,
        'start_date': startDate,
        'end_date': endDate,
      },
    );
    return result;
  }

  //function for getting income data with employee and game and date range
  Future<dynamic> getIncomeDataByEmployeeAndGameAndDateRange(
      {required BuildContext context,
      required String gameName,
      required String startDate,
      required String endDate}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_GAME_AND_DATE_RANGE,
      data: {
        'employee_username': selectedEmployee,
        'game_name': gameName,
        'start_date': startDate,
        'end_date': endDate,
      },
    );
    return result;
  }

  //function for storing income data
  Future<dynamic> addIncomeData(
      {required BuildContext context,
      required String gameName,
      required String amount,
      required String date}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.ADD_INCOME,
      data: {
        'employee_username': selectedEmployee,
        'game_name': gameName,
        'amount': amount,
        'date': date,
      },
    );
    print('the result is here : DODODODODODODODO : $result');
    return result;
  }

  //function for getting weekly data
  Future<dynamic> getAllWeeklyData(
      {required BuildContext context, required selectedDate}) async {
    await init();
    final selectedEmployee =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_employee_username)!;
    //format the selectedDate to yyyy-mm-dd
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    //use API helper
    final result = await API().postRequest(
      context: context,
      route: Constants.GET_INCOME_BY_WEEKLY_DATE,
      data: {
        'employee_username': selectedEmployee,
        'date': formattedSelectedDate,
      },
    );

    //check all possible response types and return accordingly
    if (result.statusCode == 200) {
      // Response data is already parsed as a Map
      Map<String, dynamic> jsonResponse = result.data;

      // Now you can access and process the data as needed
      List<dynamic> dataList = jsonResponse['data'];
      List<Map<String, dynamic>> gameDataList = dataList.map((item) {
        return {
          'game_name': item['game_name'],
          'amount': double.parse(item['amount']),
          'date': item['date']
        };
      }).toList();

      // Print or use the gameDataList here
      // print(gameDataList);
      return gameDataList;
    } else {
      print('Request failed with status: ${result.statusCode}');
    }
  }

  Future<List<String>> getEmployeesUsernames(
      {required BuildContext context}) async {
    await init();
    final dio = Dio(); // Create a Dio instance
    List<String> usernames = [];
    final owner =
        pref!.getString(AppConstants.STORAGE_USER_PROFILE_owner_username)!;
    try {
      // Replace 'your-api-url' with your actual API URL
      final response =
          await dio.get('${Constants.BASE_URL}employees/owner/$owner');
      if (response.statusCode == 200) {
        // Request was successful
        final responseData = response.data;

        // Extract usernames from the response data
        for (var employee in responseData['data']) {
          usernames.add(employee['username']);
        }

        print(usernames);
      } else {
        // Handle errors based on the response status code
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions (e.g., network errors)
      print('Exception: $e');
    }

    return usernames;
  }
}
