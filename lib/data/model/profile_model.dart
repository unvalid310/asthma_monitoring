class ProfileModel {
  String _id;
  String _email;
  String _fullname;
  String _dob;
  String _gender;
  String _password;
  String _createdAt;
  String _updatedAt;
  String _deletedAt;

  ProfileModel(
    String id,
    String email,
    String fullname,
    String dob,
    String gender,
    String password,
    String createdAt,
    String updatedAt,
    String deletedAt,
  ) {
    this._id = _id;
    this._email = _email;
    this._fullname = _fullname;
    this._dob = _dob;
    this._gender = _gender;
    this._password = _password;
    this._createdAt = _createdAt;
    this._updatedAt = _updatedAt;
    this._deletedAt = _deletedAt;
  }

  String get id => _id;
  String get email => _email;
  String get fullname => _fullname;
  String get dob => _dob;
  String get gender => _gender;
  String get password => _password;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  String get deletedAt => _deletedAt;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _email = json['email'];
    _fullname = json['fullname'];
    _dob = json['dob'];
    _gender = json['gender'];
    _password = json['password'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
  }
}
