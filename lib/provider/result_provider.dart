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

  bool get isLoading => _isLoading;
  ResultModel get resultModel => _resultModel;
  List<ResultModel> get historyList => _historyList;

  Future<void> getResult({String date}) async {
    _isLoading = true;

    ApiResponse apiResponse = await resultRepo.getResult(date: date);
    if (apiResponse.response.data['success']) {
      final data = apiResponse.response.data['data'] as Map<String, dynamic>;

      _resultModel = new ResultModel.fromJson(data);
    }
    _isLoading = false;

    notifyListeners();
  }

  Future<void> getHistory() async {
    _isLoading = true;
    _historyList = [];

    ApiResponse apiResponse = await resultRepo.getHistory();
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
