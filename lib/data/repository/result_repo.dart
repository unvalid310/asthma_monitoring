import 'package:asthma_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:asthma_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:asthma_monitor/data/model/response/base/api_response.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  ResultRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getResult({String date}) async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.RESULT}',
        queryParameters: {
          'user_id': sharedPreferences.getString(
            AppConstants.ID_USER,
          ),
          'date': (date != null)
              ? date
              : DateFormat('yyyy-MM-dd', 'en_US').format(DateTime.now()),
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> getHistory({String date}) async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.RESULT}/history',
        queryParameters: {
          'user_id': sharedPreferences.getString(
            AppConstants.ID_USER,
          ),
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }
}
