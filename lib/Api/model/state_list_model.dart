/// status : true
/// message : ""
/// data : [{"state_id":"1","state_name":"Alabama","country_id":"1"},{"state_id":"2","state_name":"Alaska","country_id":"1"},{"state_id":"3","state_name":"Arizona","country_id":"1"},{"state_id":"4","state_name":"Arkansas","country_id":"1"},{"state_id":"5","state_name":"California","country_id":"1"},{"state_id":"6","state_name":"Colorado","country_id":"1"},{"state_id":"7","state_name":"Connecticut","country_id":"1"},{"state_id":"8","state_name":"Delaware","country_id":"1"},{"state_id":"9","state_name":"Florida","country_id":"1"},{"state_id":"10","state_name":"Georgia","country_id":"1"},{"state_id":"11","state_name":"Hawaii","country_id":"1"},{"state_id":"12","state_name":"Idaho","country_id":"1"},{"state_id":"13","state_name":"Illinois","country_id":"1"},{"state_id":"14","state_name":"Indiana","country_id":"1"},{"state_id":"15","state_name":"Iowa","country_id":"1"},{"state_id":"16","state_name":"Kansas","country_id":"1"},{"state_id":"17","state_name":"Kentucky","country_id":"1"},{"state_id":"18","state_name":"Louisiana","country_id":"1"},{"state_id":"19","state_name":"Maine","country_id":"1"},{"state_id":"20","state_name":"Maryland","country_id":"1"},{"state_id":"21","state_name":"Massachusetts","country_id":"1"},{"state_id":"22","state_name":"Michigan","country_id":"1"},{"state_id":"23","state_name":"Minnesota","country_id":"1"},{"state_id":"24","state_name":"Mississippi","country_id":"1"},{"state_id":"25","state_name":"Missouri","country_id":"1"},{"state_id":"26","state_name":"Montana","country_id":"1"},{"state_id":"27","state_name":"Nebraska","country_id":"1"},{"state_id":"28","state_name":"Nevada","country_id":"1"},{"state_id":"29","state_name":"New Hampshire","country_id":"1"},{"state_id":"30","state_name":"New Jersey","country_id":"1"},{"state_id":"31","state_name":"New Mexico","country_id":"1"},{"state_id":"32","state_name":"New York","country_id":"1"},{"state_id":"33","state_name":"North Carolina","country_id":"1"},{"state_id":"34","state_name":"North Dakota","country_id":"1"},{"state_id":"35","state_name":"Ohio","country_id":"1"},{"state_id":"36","state_name":"Oklahoma","country_id":"1"},{"state_id":"37","state_name":"Oregon","country_id":"1"},{"state_id":"38","state_name":"Pennsylvania","country_id":"1"},{"state_id":"39","state_name":"Rhode Island","country_id":"1"},{"state_id":"40","state_name":"South Carolina","country_id":"1"},{"state_id":"41","state_name":"South Dakota","country_id":"1"},{"state_id":"42","state_name":"Tennessee","country_id":"1"},{"state_id":"43","state_name":"Texas","country_id":"1"},{"state_id":"44","state_name":"Utah","country_id":"1"},{"state_id":"45","state_name":"Vermont","country_id":"1"},{"state_id":"46","state_name":"Virginia","country_id":"1"},{"state_id":"47","state_name":"Washington","country_id":"1"},{"state_id":"48","state_name":"West Virginia","country_id":"1"},{"state_id":"49","state_name":"Wisconsin","country_id":"1"},{"state_id":"50","state_name":"Wyoming","country_id":"1"}]

class StateListModel {
  StateListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  StateListModel.fromJson(dynamic json) {
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

/// state_id : "1"
/// state_name : "Alabama"
/// country_id : "1"

class Data {
  Data({
      String? stateId, 
      String? stateName, 
      String? countryId,}){
    _stateId = stateId;
    _stateName = stateName;
    _countryId = countryId;
}

  Data.fromJson(dynamic json) {
    _stateId = json['state_id'];
    _stateName = json['state_name'];
    _countryId = json['country_id'];
  }
  String? _stateId;
  String? _stateName;
  String? _countryId;

  String? get stateId => _stateId;
  String? get stateName => _stateName;
  String? get countryId => _countryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['state_id'] = _stateId;
    map['state_name'] = _stateName;
    map['country_id'] = _countryId;
    return map;
  }

}