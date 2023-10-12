import 'package:dio/dio.dart';
import 'package:gamezoning/Model/api_constants.dart';

class API {
  postRequest({
    required String route,
    required Map<String, String> data,
  }) async {
    //use dio package
    final dio = Dio();
    //handle all status
    return await dio.post(AppConstants.API_URL + route, data: data);
  }

  //
}
