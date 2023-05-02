import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:asthma_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:asthma_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:asthma_monitor/data/model/response/base/api_response.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> registration(Map<String, dynamic> data) async {
    try {
      Response response = await dioClient
          .post(
            AppConstants.REGISTER_URI,
            data: data,
          )
          .timeout(const Duration(seconds: 10));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(
          ApiErrorHandler.getMessage('Terjadi kesalahan'));
    }
  }

  Future<void> saveUserData(
      {@required int idUser, String email, String fullname}) async {
    try {
      sharedPreferences.setString(AppConstants.ID_USER, idUser.toString());
      sharedPreferences.setString(AppConstants.EMAIL, email);
      sharedPreferences.setString(AppConstants.NAME, fullname);
    } catch (e) {}
  }

  Future<ApiResponse> login(String email, String password) async {
    try {
      Response response = await dioClient.post(
        AppConstants.LOGIN_URI,
        data: FormData.fromMap({
          "email": email,
          "password": password,
        }),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  // for verify phone number
  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.ID_USER);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.clear();
    return true;
  }
}
