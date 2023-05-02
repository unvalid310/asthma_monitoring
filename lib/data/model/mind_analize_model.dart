class MindAnalizeModel {
  String _id;
  String _userId;
  String _q1;
  String _q2;
  String _q3;
  String _q4;
  String _q5;
  String _q6;
  String _q7;
  String _q8;
  String _q9;
  String _q10;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;

  MindAnalizeModel(
    String id,
    String userId,
    String q1,
    String q2,
    String q3,
    String q4,
    String q5,
    String q6,
    String q7,
    String q8,
    String q9,
    String q10,
    String createdAt,
    String updatedAt,
    String deletedAt,
  ) {
    this._id = id;
    this._userId = userId;
    this._q1 = q1;
    this._q2 = q2;
    this._q3 = q3;
    this._q4 = q4;
    this._q5 = q5;
    this._q6 = q6;
    this._q7 = q7;
    this._q8 = q8;
    this._q9 = q9;
    this._q10 = q10;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
    this._deletedAt = deletedAt;
  }

  String get id => _id;
  String get userId => _userId;
  String get q1 => _q1;
  String get q2 => _q2;
  String get q3 => _q3;
  String get q4 => _q4;
  String get q5 => _q5;
  String get q6 => _q6;
  String get q7 => _q7;
  String get q8 => _q8;
  String get q9 => _q9;
  String get q10 => _q10;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get deletedAt => _deletedAt;

  MindAnalizeModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _q1 = json['q1'];
    _q2 = json['q2'];
    _q3 = json['q3'];
    _q4 = json['q4'];
    _q5 = json['q5'];
    _q6 = json['q6'];
    _q7 = json['q7'];
    _q8 = json['q8'];
    _q9 = json['q9'];
    _q10 = json['q10'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
}
