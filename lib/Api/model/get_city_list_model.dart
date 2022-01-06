/// status : true
/// message : ""
/// data : [{"city_id":"1","city_name":"Alexander City","state_id":"1"},{"city_id":"2","city_name":"Andalusia","state_id":"1"},{"city_id":"3","city_name":"Anniston","state_id":"1"},{"city_id":"4","city_name":"Athens","state_id":"1"},{"city_id":"5","city_name":"Atmore","state_id":"1"},{"city_id":"6","city_name":"Auburn","state_id":"1"},{"city_id":"7","city_name":"Bessemer","state_id":"1"},{"city_id":"8","city_name":"Birmingham","state_id":"1"},{"city_id":"9","city_name":"Chickasaw","state_id":"1"},{"city_id":"10","city_name":"Clanton","state_id":"1"},{"city_id":"11","city_name":"Cullman","state_id":"1"},{"city_id":"12","city_name":"Decatur","state_id":"1"},{"city_id":"13","city_name":"Demopolis","state_id":"1"},{"city_id":"14","city_name":"Dothan","state_id":"1"},{"city_id":"15","city_name":"Enterprise","state_id":"1"},{"city_id":"16","city_name":"Eufaula","state_id":"1"},{"city_id":"17","city_name":"Florence","state_id":"1"},{"city_id":"18","city_name":"Fort Payne","state_id":"1"},{"city_id":"19","city_name":"Gadsden","state_id":"1"},{"city_id":"20","city_name":"Greenville","state_id":"1"},{"city_id":"21","city_name":"Guntersville","state_id":"1"},{"city_id":"22","city_name":"Huntsville","state_id":"1"},{"city_id":"23","city_name":"Jasper","state_id":"1"},{"city_id":"24","city_name":"Marion","state_id":"1"},{"city_id":"25","city_name":"Mobile","state_id":"1"},{"city_id":"26","city_name":"Montgomery","state_id":"1"},{"city_id":"27","city_name":"Opelika","state_id":"1"},{"city_id":"28","city_name":"Ozark","state_id":"1"},{"city_id":"29","city_name":"Phenix City","state_id":"1"},{"city_id":"30","city_name":"Prichard","state_id":"1"},{"city_id":"31","city_name":"Scottsboro","state_id":"1"},{"city_id":"32","city_name":"Selma","state_id":"1"},{"city_id":"33","city_name":"Sheffield","state_id":"1"},{"city_id":"34","city_name":"Sylacauga","state_id":"1"},{"city_id":"35","city_name":"Talladega","state_id":"1"},{"city_id":"36","city_name":"Troy","state_id":"1"},{"city_id":"37","city_name":"Tuscaloosa","state_id":"1"},{"city_id":"38","city_name":"Tuscumbia","state_id":"1"},{"city_id":"39","city_name":"Tuskegee","state_id":"1"}]

class GetCityListModel {
  GetCityListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetCityListModel.fromJson(dynamic json) {
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

/// city_id : "1"
/// city_name : "Alexander City"
/// state_id : "1"

class Data {
  Data({
      String? cityId, 
      String? cityName, 
      String? stateId,}){
    _cityId = cityId;
    _cityName = cityName;
    _stateId = stateId;
}

  Data.fromJson(dynamic json) {
    _cityId = json['city_id'];
    _cityName = json['city_name'];
    _stateId = json['state_id'];
  }
  String? _cityId;
  String? _cityName;
  String? _stateId;

  String? get cityId => _cityId;
  String? get cityName => _cityName;
  String? get stateId => _stateId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_id'] = _cityId;
    map['city_name'] = _cityName;
    map['state_id'] = _stateId;
    return map;
  }

}