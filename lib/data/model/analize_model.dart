class AnalizeModel {
  double _body;
  double _envi;
  double _mind;
  double _max;

  AnalizeModel(
    double body,
    double envi,
    double mind,
    double max,
  ) {
    this._body = body;
    this._envi = envi;
    this._mind = mind;
    this._max = max;
  }

  double get body => _body;
  double get envi => _envi;
  double get mind => _mind;
  double get max => _max;

  AnalizeModel.fromJson(Map<String, dynamic> json) {
    _body = (json['body'] == 0) ? 0.0 : double.parse(json['body'].toString());
    _envi = (json['envi'] == 0) ? 0.0 : double.parse(json['envi'].toString());
    _mind = (json['mind'] == 0) ? 0.0 : double.parse(json['mind'].toString());
    _max = (json['max'] == 0) ? 0.0 : double.parse(json['max'].toString());
  }
}
