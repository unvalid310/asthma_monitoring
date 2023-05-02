class ResultModel {
  String _date;
  double _body;
  double _envi;
  double _mind;
  double _max;

  ResultModel(
    String date,
    double body,
    double envi,
    double mind,
    double max,
  ) {
    this._date = date;
    this._body = body;
    this._envi = envi;
    this._mind = mind;
    this._max = max;
  }

  String get date => _date;
  double get body => _body;
  double get envi => _envi;
  double get mind => _mind;
  double get max => _max;

  ResultModel.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _body = (json['body'] == 0) ? 0.0 : double.parse(json['body'].toString());
    _envi = (json['envi'] == 0) ? 0.0 : double.parse(json['envi'].toString());
    _mind = (json['mind'] == 0) ? 0.0 : double.parse(json['mind'].toString());
    _max = (json['max'] == 0) ? 0.0 : double.parse(json['max'].toString());
  }
}
