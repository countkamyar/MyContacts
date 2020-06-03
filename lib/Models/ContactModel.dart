class ContactModel {
  int _id;

  int get id => _id;

  set id(int id) {
    if (id != null) {
      _id = id;
    }
  }

  String _first_name;

  String get first_name => _first_name;

  set first_name(String first_name) {
    if (first_name != null) {
      _first_name = first_name;
    }
  }

  String _last_name;

  String get last_name => _last_name;

  set last_name(String last_name) {
    if (last_name != null) {
      _last_name = last_name;
    }
  }

  String _phone_no;

  String get phone_no => _phone_no;

  set phone_no(String phone_no) {
    if (phone_no != null) {
      _phone_no = phone_no;
    }
  }

  String _email;

  String get email => _email;

  set email(String email) {
    if (email != null) {
      _email = email;
    }
  }

  String _date_of_birth;

  String get date_of_birth => _date_of_birth;

  set date_of_birth(String date_of_birth) {
    if (date_of_birth != null) {
      _date_of_birth = date_of_birth;
    }
  }

  String _gender;

  String get gender => _gender;

  set gender(String gender) {
    if (gender != null) {
      _gender = gender;
    }
  }

  ContactModel(this._id, this._first_name, this._last_name, this._phone_no,
      this._email, this._date_of_birth, this._gender);
  ContactModel.withoutid(this._first_name, this._last_name, this._phone_no,
      this._email, this._date_of_birth, this._gender);
  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
      json["id"],
      json["first_name"],
      json["last_name"],
      json["date_of_birth"],
      json["phone_no"],
      json["email"],
      json["gender"]);

  //   Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "name": name,
  //       "address": address,
  //       "email": email,
  //   };

  //converting Contact object to Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
      map['fist_name'] = _first_name;
      map['last_name'] = _last_name;
      map['date_of_birth'] = _date_of_birth;
      map['phone_no'] = _phone_no;
      map['email'] = _email;
      map['gender'] = _gender;
      return map;
    }
  }

  //extracting Map object from Contact object
  ContactModel.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._first_name = map['fist_name'];
    this._last_name = map['last_name'];
    this._date_of_birth = map['date_of_birth'];
    this._phone_no = map['phone_no'];
    this._email = map['email'];
    this._gender = map['gender'];
  }
}
