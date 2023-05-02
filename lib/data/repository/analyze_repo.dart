import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:asthma_monitor/data/datasource/remote/dio/dio_client.dart';
import 'package:asthma_monitor/data/datasource/remote/exception/api_error_handler.dart';
import 'package:asthma_monitor/data/model/response/base/api_response.dart';
import 'package:asthma_monitor/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnalyzeRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AnalyzeRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getAnalize() async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.ANALYZE}',
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

  Future<ApiResponse> getBodyAnalize() async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.BODY_ANALYZE}',
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

  Future<ApiResponse> postBodyAnalize({Map<String, dynamic> data}) async {
    data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

    try {
      Response response = await dioClient.post(
        '${AppConstants.BODY_ANALYZE}/create',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> updateBodyAnalize(
      {Map<String, dynamic> data, int id}) async {
    data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

    try {
      Response response = await dioClient.post(
        '${AppConstants.BODY_ANALYZE}/update/$id',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> getEnviAnalize() async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.ENVI_ANALYZE}',
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

  Future<ApiResponse> postEnviAnalize({Map<String, dynamic> data}) async {
    data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

    try {
      Response response = await dioClient.post(
        '${AppConstants.ENVI_ANALYZE}/create',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> updateEnviAnalize(
      {Map<String, dynamic> data, int id}) async {
    data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

    try {
      Response response = await dioClient.post(
        '${AppConstants.ENVI_ANALYZE}/update/$id',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> getMindAnalize() async {
    try {
      Response response = await dioClient.get(
        '${AppConstants.MIND_ANALYZE}',
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

  Future<ApiResponse> postMindAnalize({Map<String, dynamic> data}) async {
    data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

    try {
      Response response = await dioClient.post(
        '${AppConstants.MIND_ANALYZE}/create',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }

  Future<ApiResponse> updateMindAnalize(
      {Map<String, dynamic> data, int id}) async {
    data['user_id'] = sharedPreferences.getString(AppConstants.ID_USER);

    try {
      Response response = await dioClient.post(
        '${AppConstants.MIND_ANALYZE}/update/$id',
        data: data,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e.toString()));
    }
  }
}
