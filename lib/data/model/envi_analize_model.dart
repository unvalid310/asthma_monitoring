class EnviAnalizeModel {
  String _id;
  String _userId;
  String _temperature;
  String _humidity;
  String _co2;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;

  EnviAnalizeModel(
    String id,
    String userId,
    String temperature,
    String humidity,
    String co2,
    String createdAt,
    String updatedAt,
    String deletedAt,
  ) {
    this._id = id;
    this._userId = userId;
    this._temperature = temperature;
    this._humidity = humidity;
    this._co2 = co2;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deletedAt = deletedAt;
  }

  String get id => _id;
  String get userId => _userId;
  String get temperature => _temperature;
  String get humidity => _humidity;
  String get co2 => _co2;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get deletedAt => _deletedAt;

  EnviAnalizeModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _temperature = json['temperature'];
    _humidity = json['humidity'];
    _co2 = json['co2'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
}
