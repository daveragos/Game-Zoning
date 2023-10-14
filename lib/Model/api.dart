import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gamezoning/Model/alert_dialog.dart' as Alert;
import 'package:gamezoning/Model/api_constants.dart';
import 'package:gamezoning/Model/api_exceptions.dart';

class API {
  Alert.AlertDialog alertDialog = Alert.AlertDialog();
  postRequest(
      {required String route,
      required Map<String, String> data,
      required BuildContext context}) async {
    //use dio package
    final dio = Dio();
    //handle all errors that could occur using try catch
    try {
      final response = await dio.post(AppConstants.API_URL + route, data: data);
      return response;
    } on DioException catch (e) {
      checkException(e, context);
    } catch (e) {
      alertDialog.showAlert(
          context: context, title: 'Error', content: e.toString());
    }
  }

  void checkException(DioException error, BuildContext context) {
    APIException exception = APIException();
    final List<String> message = exception.getExceptionMessage(error);
    alertDialog.showAlert(
      context: context,
      title: message[0],
      content: message[1],
    );
  }
}
