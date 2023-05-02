class BodyAnalizeModel {
  String _id;
  String _userId;
  String _heartRate;
  String _spo2;
  String _sleepingQuality;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;

  BodyAnalizeModel(
    String id,
    String userId,
    String heartRate,
    String spo2,
    String sleepingQuality,
    String createdAt,
    String updatedAt,
    String deletedAt,
  ) {
    this._id = id;
    this._userId = userId;
    this._heartRate = heartRate;
    this._spo2 = spo2;
    this._sleepingQuality = sleepingQuality;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deletedAt = deletedAt;
  }

  String get id => _id;
  String get userId => _userId;
  String get heartRate => _heartRate;
  String get spo2 => _spo2;
  String get sleepingQuality => _sleepingQuality;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get deletedAt => _deletedAt;

  BodyAnalizeModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _heartRate = json['heart_rate'];
    _spo2 = json['spo2'];
    _sleepingQuality = json['sleeping_quality'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
}
