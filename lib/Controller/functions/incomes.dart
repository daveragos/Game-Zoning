import 'package:dio/dio.dart';
import 'package:gamezoning/Controller/Constants/https_route_consts.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:intl/intl.dart';

class Income {
  //function for getting income data with employee
  Future<dynamic> getIncomeDataByEmployee(
      {required String employeeUserName}) async {
    //use dio package
    final dio = Dio();
    return await dio
        .post(AppConstants.API_URL + Constants.GET_INCOME_BY_EMPLOYEES, data: {
      'employee_username': employeeUserName,
    });
  }

  //function for getting income data with employee and date
  Future<dynamic> getIncomeDataByEmployeeAndDate(
      {required String employeeUserName, required String date}) async {
    //use dio package
    final dio = Dio();
    var response = await dio
        .post(AppConstants.API_URL + Constants.GET_INCOME_BY_DATE, data: {
      'employee_username': employeeUserName,
      'date': date,
    });

    //check all possible response types and return accordingly
    if (response.statusCode == 200) {
      // Response data is already parsed as a Map
      Map<String, dynamic> jsonResponse = response.data;

      // Now you can access and process the data as needed
      List<dynamic> dataList = jsonResponse['data'];
      List<Map<String, dynamic>> gameDataList = dataList.map((item) {
        return {
          'game_name': item['game_name'],
          'amount': double.parse(item['amount']),
        };
      }).toList();

      // Print or use the gameDataList here
      // print(gameDataList);
      return gameDataList;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  //function for getting income data with employee and game
  Future<dynamic> getIncomeDataByEmployeeAndGame(
      {required String employeeUserName, required String gameName}) async {
    //use dio package
    final dio = Dio();
    return await dio
        .post(AppConstants.API_URL + Constants.GET_INCOME_BY_GAME, data: {
      'employee_username': employeeUserName,
      'game_name': gameName,
    });
  }

  //function for getting income data with employee and game and date
  Future<dynamic> getIncomeDataByEmployeeAndGameAndDate(
      {required String employeeUserName,
      required String gameName,
      required String date}) async {
    //use dio package
    final dio = Dio();
    return await dio.post(
        AppConstants.API_URL + Constants.GET_INCOME_BY_DATE_AND_GAME,
        data: {
          'employee_username': employeeUserName,
          'game_name': gameName,
          'date': date,
        });
  }

  //function for getting income data with employee and date range
  Future<dynamic> getIncomeDataByEmployeeAndDateRange(
      {required String employeeUserName,
      required String startDate,
      required String endDate}) async {
    //use dio package
    final dio = Dio();
    return await dio
        .post(AppConstants.API_URL + Constants.GET_INCOME_BY_DATE_RANGE, data: {
      'employee_username': employeeUserName,
      'start_date': startDate,
      'end_date': endDate,
    });
  }

  //function for getting income data with employee and game and date range
  Future<dynamic> getIncomeDataByEmployeeAndGameAndDateRange(
      {required String employeeUserName,
      required String gameName,
      required String startDate,
      required String endDate}) async {
    //use dio package
    final dio = Dio();
    return await dio.post(
        AppConstants.API_URL + Constants.GET_INCOME_BY_GAME_AND_DATE_RANGE,
        data: {
          'employee_username': employeeUserName,
          'game_name': gameName,
          'start_date': startDate,
          'end_date': endDate,
        });
  }

  //function for storing income data
  Future<dynamic> addIncomeData(
      {required String employeeUserName,
      required String gameName,
      required String amount,
      required String date}) async {
    //use dio package
    final dio = Dio();
    return await dio.post(AppConstants.API_URL + Constants.ADD_INCOME, data: {
      'employee_username': employeeUserName,
      'game_name': gameName,
      'amount': amount,
      'date': date,
    });
  }

//function for getting weekly data
  Future<dynamic> getAllWeeklyData() async {
    //format the selectedDate to yyyy-mm-dd
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(DateTime(2023, 09, 27));

    //use dio package
    final dio = Dio();
    var response = await dio.post(
        AppConstants.API_URL + Constants.GET_INCOME_BY_WEEKLY_DATE,
        data: {
          'employee_username': 'employee3name',
          'date': formattedSelectedDate,
        });

    //check all possible response types and return accordingly
    if (response.statusCode == 200) {
      // Response data is already parsed as a Map
      Map<String, dynamic> jsonResponse = response.data;

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
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<List<String>> getEmployeesUsernames() async {
    final dio = Dio(); // Create a Dio instance
    List<String> usernames = [];

    try {
      // Replace 'your-api-url' with your actual API URL
      final response =
          await dio.get('${Constants.BASE_URL}employees/owner/owner3name');

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
