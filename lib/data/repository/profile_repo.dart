import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:asthma_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:asthma_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:asthma_monitor/data/model/response/base/api_response.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ProfileRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getProfile() async {
    try {
      print('user id >> ${sharedPreferences.getString(AppConstants.ID_USER)}');
      Response response = await dioClient.get(
        AppConstants.PROFILE,
        queryParameters: {
          'user_id': sharedPreferences.getString(AppConstants.ID_USER)
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> updateProfile({Map<String, dynamic> data}) async {
    try {
      Response response = await dioClient.post(
        '${AppConstants.PROFILE}/update/${sharedPreferences.getString(AppConstants.ID_USER)}',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }
}
