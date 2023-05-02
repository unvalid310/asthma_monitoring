import 'package:asthma_monitor/data/model/analize_model.dart';
import 'package:asthma_monitor/data/model/body_analize_model.dart';
import 'package:asthma_monitor/data/model/envi_analize_model.dart';
import 'package:asthma_monitor/data/model/mind_analize_model.dart';
import 'package:asthma_monitor/data/model/mind_analize_model.dart';
import 'package:asthma_monitor/data/model/response/response_model.dart';
import 'package:flutter/foundation.dart';
import 'package:asthma_monitor/data/model/response/base/api_response.dart';
import 'package:asthma_monitor/data/repository/analyze_repo.dart';

class AnalyzeProvider extends ChangeNotifier {
  final AnalyzeRepo analyzeRepo;
  AnalyzeProvider({@required this.analyzeRepo});

  bool _isloading = false;
  AnalizeModel _analizeModel;
  BodyAnalizeModel _bodyAnalizeModel;
  EnviAnalizeModel _enviAnalizeModel;
  MindAnalizeModel _mindAnalizeModel;

  bool get isLoading => _isloading;
  AnalizeModel get analizeModel => _analizeModel;
  BodyAnalizeModel get bodyAnalizeModel => _bodyAnalizeModel;
  EnviAnalizeModel get enviAnalizeModel => _enviAnalizeModel;
  MindAnalizeModel get mindAnalizeModel => _mindAnalizeModel;

  Future<void> getAnalyze() async {
    _isloading = true;

    ApiResponse apiResponse = await analyzeRepo.getAnalize();
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'] as Map<String, dynamic>;

      _analizeModel = new AnalizeModel.fromJson(data);
      print('body >> ${_analizeModel.body}');
    }
    _isloading = false;

    notifyListeners();
  }

  Future<void> getBodyAnalyze() async {
    _isloading = true;

    ApiResponse apiResponse = await analyzeRepo.getBodyAnalize();
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'] as Map<String, dynamic>;

      _bodyAnalizeModel = new BodyAnalizeModel.fromJson(data);
      print('body >> ${_analizeModel.body}');
    }
    _isloading = false;

    notifyListeners();
  }

  Future<ResponseModel> postBodyAnalize({Map<String, dynamic> data}) async {
    _isloading = true;
    ApiResponse apiResponse = await analyzeRepo.postBodyAnalize(data: data);
    ResponseModel responseModel;
    print('response >> ${apiResponse.response}');
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isloading = false;
    }

    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> updateBodyAnalize(
      {Map<String, dynamic> data, int id}) async {
    _isloading = true;
    ApiResponse apiResponse =
        await analyzeRepo.updateBodyAnalize(data: data, id: id);
    ResponseModel responseModel;
    print('response >> ${apiResponse.response}');
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isloading = false;
    }

    notifyListeners();
    return responseModel;
  }

  // Envi
  Future<void> getEnviAnalyze() async {
    _isloading = true;

    ApiResponse apiResponse = await analyzeRepo.getEnviAnalize();
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'] as Map<String, dynamic>;

      _enviAnalizeModel = new EnviAnalizeModel.fromJson(data);
    }
    _isloading = false;

    notifyListeners();
  }

  Future<ResponseModel> postEnviAnalize({Map<String, dynamic> data}) async {
    _isloading = true;
    ApiResponse apiResponse = await analyzeRepo.postEnviAnalize(data: data);
    ResponseModel responseModel;
    print('response >> ${apiResponse.response}');
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isloading = false;
    }

    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> updateEnviAnalize(
      {Map<String, dynamic> data, int id}) async {
    _isloading = true;
    ApiResponse apiResponse =
        await analyzeRepo.updateEnviAnalize(data: data, id: id);
    ResponseModel responseModel;
    print('response >> ${apiResponse.response}');
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isloading = false;
    }

    notifyListeners();
    return responseModel;
  }

  // Mind
  Future<void> getMindAnalyze() async {
    _isloading = true;

    ApiResponse apiResponse = await analyzeRepo.getMindAnalize();
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'] as Map<String, dynamic>;

      _mindAnalizeModel = new MindAnalizeModel.fromJson(data);
    }
    _isloading = false;

    notifyListeners();
  }

  Future<ResponseModel> postMindAnalize({Map<String, dynamic> data}) async {
    _isloading = true;
    ApiResponse apiResponse = await analyzeRepo.postMindAnalize(data: data);
    ResponseModel responseModel;
    print('response >> ${apiResponse.response}');
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isloading = false;
    }

    notifyListeners();
    return responseModel;
  }

  Future<ResponseModel> updateMindAnalize(
      {Map<String, dynamic> data, int id}) async {
    _isloading = true;
    ApiResponse apiResponse =
        await analyzeRepo.updateMindAnalize(data: data, id: id);
    ResponseModel responseModel;
    print('response >> ${apiResponse.response}');
    if (apiResponse.response.data['success']) {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
    } else {
      responseModel = ResponseModel(apiResponse.response.data['success'],
          apiResponse.response.data['message']);
      _isloading = false;
    }

    notifyListeners();
    return responseModel;
  }
}
