/// status : true
/// message : ""
/// data : [{"address_id":"3","user_id":"44","country_id":"1","state_id":"1","city_id":"1","full_name":"ae","email":"ae@gmail.com","address":"ar","area":"af","zip":"34231","mobile_no":"2147483647","added_on":"2022-01-03 16:38:24","update_on":"2022-01-03 16:38:24","state_name":"Alabama","city_name":"Alexander City"},{"address_id":"4","user_id":"44","country_id":"1","state_id":"1","city_id":"1","full_name":"ae","email":"ae@gmail.com","address":"ar","area":"af","zip":"34231","mobile_no":"2147483647","added_on":"2022-01-03 16:38:32","update_on":"2022-01-03 16:38:32","state_name":"Alabama","city_name":"Alexander City"},{"address_id":"5","user_id":"44","country_id":null,"state_id":"1","city_id":"1","full_name":"ae","email":"ae@gmail.com","address":"ar","area":"af","zip":"34231","mobile_no":"2147483647","added_on":"2022-01-04 19:17:49","update_on":"2022-01-04 19:17:49","state_name":"Alabama","city_name":"Alexander City"}]

class GetAddressListModel {
  GetAddressListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAddressListModel.fromJson(dynamic json) {
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

/// address_id : "3"
/// user_id : "44"
/// country_id : "1"
/// state_id : "1"
/// city_id : "1"
/// full_name : "ae"
/// email : "ae@gmail.com"
/// address : "ar"
/// area : "af"
/// zip : "34231"
/// mobile_no : "2147483647"
/// added_on : "2022-01-03 16:38:24"
/// update_on : "2022-01-03 16:38:24"
/// state_name : "Alabama"
/// city_name : "Alexander City"

class Data {
  Data({
      String? addressId, 
      String? userId, 
      String? countryId, 
      String? stateId, 
      String? cityId, 
      String? fullName, 
      String? email, 
      String? address, 
      String? area, 
      String? zip, 
      String? mobileNo, 
      String? addedOn, 
      String? updateOn, 
      String? stateName, 
      String? cityName,}){
    _addressId = addressId;
    _userId = userId;
    _countryId = countryId;
    _stateId = stateId;
    _cityId = cityId;
    _fullName = fullName;
    _email = email;
    _address = address;
    _area = area;
    _zip = zip;
    _mobileNo = mobileNo;
    _addedOn = addedOn;
    _updateOn = updateOn;
    _stateName = stateName;
    _cityName = cityName;
}

  Data.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _userId = json['user_id'];
    _countryId = json['country_id'];
    _stateId = json['state_id'];
    _cityId = json['city_id'];
    _fullName = json['full_name'];
    _email = json['email'];
    _address = json['address'];
    _area = json['area'];
    _zip = json['zip'];
    _mobileNo = json['mobile_no'];
    _addedOn = json['added_on'];
    _updateOn = json['update_on'];
    _stateName = json['state_name'];
    _cityName = json['city_name'];
  }
  String? _addressId;
  String? _userId;
  String? _countryId;
  String? _stateId;
  String? _cityId;
  String? _fullName;
  String? _email;
  String? _address;
  String? _area;
  String? _zip;
  String? _mobileNo;
  String? _addedOn;
  String? _updateOn;
  String? _stateName;
  String? _cityName;

  String? get addressId => _addressId;
  String? get userId => _userId;
  String? get countryId => _countryId;
  String? get stateId => _stateId;
  String? get cityId => _cityId;
  String? get fullName => _fullName;
  String? get email => _email;
  String? get address => _address;
  String? get area => _area;
  String? get zip => _zip;
  String? get mobileNo => _mobileNo;
  String? get addedOn => _addedOn;
  String? get updateOn => _updateOn;
  String? get stateName => _stateName;
  String? get cityName => _cityName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['user_id'] = _userId;
    map['country_id'] = _countryId;
    map['state_id'] = _stateId;
    map['city_id'] = _cityId;
    map['full_name'] = _fullName;
    map['email'] = _email;
    map['address'] = _address;
    map['area'] = _area;
    map['zip'] = _zip;
    map['mobile_no'] = _mobileNo;
    map['added_on'] = _addedOn;
    map['update_on'] = _updateOn;
    map['state_name'] = _stateName;
    map['city_name'] = _cityName;
    return map;
  }

}