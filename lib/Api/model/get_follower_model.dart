/// status : true
/// message : ""
/// data : [{"id":"2","user_id":"31","vendor_id":"4","type":"follow","created_at":"2021-11-01 10:14:00","updated_at":"2021-11-10 06:32:31","username":"Mohit Sen","profile_photo_url":"https://bodyrecomp.app/app/project/ecom/uploads/user_image/user_image1935.jpg","address1":"8502 Preston Rd. Inglewood, Maine 98380","state_name":"Alabama","city_name":"Athens","zip":"454005"}]

class GetFollowerModel {
  GetFollowerModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetFollowerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "2"
/// user_id : "31"
/// vendor_id : "4"
/// type : "follow"
/// created_at : "2021-11-01 10:14:00"
/// updated_at : "2021-11-10 06:32:31"
/// username : "Mohit Sen"
/// profile_photo_url : "https://bodyrecomp.app/app/project/ecom/uploads/user_image/user_image1935.jpg"
/// address1 : "8502 Preston Rd. Inglewood, Maine 98380"
/// state_name : "Alabama"
/// city_name : "Athens"
/// zip : "454005"

class Data {
  Data({
      String? id, 
      String? userId, 
      String? vendorId, 
      String? type, 
      String? createdAt, 
      String? updatedAt, 
      String? username, 
      String? profilePhotoUrl, 
      String? address1, 
      String? stateName, 
      String? cityName, 
      String? zip,}){
    _id = id;
    _userId = userId;
    _vendorId = vendorId;
    _type = type;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _username = username;
    _profilePhotoUrl = profilePhotoUrl;
    _address1 = address1;
    _stateName = stateName;
    _cityName = cityName;
    _zip = zip;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _vendorId = json['vendor_id'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _username = json['username'];
    _profilePhotoUrl = json['profile_photo_url'];
    _address1 = json['address1'];
    _stateName = json['state_name'];
    _cityName = json['city_name'];
    _zip = json['zip'];
  }
  String? _id;
  String? _userId;
  String? _vendorId;
  String? _type;
  String? _createdAt;
  String? _updatedAt;
  String? _username;
  String? _profilePhotoUrl;
  String? _address1;
  String? _stateName;
  String? _cityName;
  String? _zip;

  String? get id => _id;
  String? get userId => _userId;
  String? get vendorId => _vendorId;
  String? get type => _type;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get username => _username;
  String? get profilePhotoUrl => _profilePhotoUrl;
  String? get address1 => _address1;
  String? get stateName => _stateName;
  String? get cityName => _cityName;
  String? get zip => _zip;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['vendor_id'] = _vendorId;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['username'] = _username;
    map['profile_photo_url'] = _profilePhotoUrl;
    map['address1'] = _address1;
    map['state_name'] = _stateName;
    map['city_name'] = _cityName;
    map['zip'] = _zip;
    return map;
  }

}