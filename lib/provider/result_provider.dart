import 'package:asthma_monitor/data/model/body_analize_model.dart';
import 'package:asthma_monitor/data/model/envi_analize_model.dart';
import 'package:asthma_monitor/data/model/mind_analize_model.dart';
import 'package:asthma_monitor/data/model/response/base/api_response.dart';
import 'package:asthma_monitor/data/model/result_model.dart';
import 'package:asthma_monitor/data/repository/result_repo.dart';
import 'package:flutter/cupertino.dart';

class ResultProvider extends ChangeNotifier {
  final ResultRepo resultRepo;

  ResultProvider({@required this.resultRepo});

  bool _isLoading = false;
  ResultModel _resultModel;
  List<ResultModel> _historyList = [];
  BodyAnalizeModel _bodyResult;
  EnviAnalizeModel _enviResult;
  MindAnalizeModel _mindResult;

  bool get isLoading => _isLoading;
  ResultModel get resultModel => _resultModel;
  List<ResultModel> get historyList => _historyList;
  BodyAnalizeModel get bodyResult => _bodyResult;
  EnviAnalizeModel get enviResult => _enviResult;
  MindAnalizeModel get mindResult => _mindResult;

  Future<void> getResult({String date}) async {
    _isLoading = true;

    ApiResponse apiResponse = await resultRepo.getResult(date: date);
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'] as Map<String, dynamic>;

      if (data['body'] != null) {
        _bodyResult =
            BodyAnalizeModel.fromJson(data['body'] as Map<String, dynamic>);
      }
      if (data['envi'] != null) {
        _enviResult =
            EnviAnalizeModel.fromJson(data['envi'] as Map<String, dynamic>);
      }
      if (data['mind'] != null) {
        _mindResult =
            MindAnalizeModel.fromJson(data['mind'] as Map<String, dynamic>);
      }
    }
    _isLoading = false;

    notifyListeners();
  }

  Future<void> getHistory({String bulan, String tahun}) async {
    _isLoading = true;
    _historyList = [];

    ApiResponse apiResponse =
        await resultRepo.getHistory(bulan: bulan, tahun: tahun);
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'];

      data.forEach(
        (value) => _historyList.add(ResultModel.fromJson(value)),
      );

      _isLoading = false;
    } else {
      _isLoading = false;
    }

    notifyListeners();
  }
}
