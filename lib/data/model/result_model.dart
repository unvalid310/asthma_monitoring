class ResultModel {
  String _date;
  double _body;
  double _envi;
  double _mind;
  double _max;
  String _indicator;

  ResultModel(
    String date,
    double body,
    double envi,
    double mind,
    double max,
    String indicator,
  ) {
    this._date = date;
    this._body = body;
    this._envi = envi;
    this._mind = mind;
    this._max = max;
    this._indicator = indicator;
  }

  String get date => _date;
  double get body => _body;
  double get envi => _envi;
  double get mind => _mind;
  double get max => _max;
  String get indocator => _indicator;

  ResultModel.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _body = (json['body'].toString() == '0.0')
        ? 0.0
        : double.parse(json['body'].toString());
    _envi = (json['envi'].toString() == '0.0')
        ? 0.0
        : double.parse(json['envi'].toString());
    _mind = (json['mind'].toString() == '0.0')
        ? 0.0
        : double.parse(json['mind'].toString());
    _max = (json['max'].toString() == '0.0')
        ? 0.0
        : double.parse(json['max'].toString());
    _indicator = json['indicator'];
  }
}
