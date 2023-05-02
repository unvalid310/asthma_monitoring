import 'package:flutter/cupertino.dart';

class SliderProvider extends ChangeNotifier {
  double _stateChangeValue = 3.0;

  double get stateChangeValue => _stateChangeValue;

  set stateChangeValue(double value) {
    _stateChangeValue = value;

    notifyListeners();
  }

  void setValue(double value) {
    _stateChangeValue = value;

    notifyListeners();
  }
}
