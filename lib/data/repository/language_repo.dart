import 'package:flutter/material.dart';
import 'package:asthma_monitor/data/model/response/language_model.dart';
import 'package:asthma_monitor/utill/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
