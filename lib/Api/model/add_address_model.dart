/// status : true
/// message : "Your Address submit successfully."
/// data : 6

class AddAddressModel {
  AddAddressModel({
      bool? status, 
      String? message, 
      int? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  AddAddressModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _status;
  String? _message;
  int? _data;

  bool? get status => _status;
  String? get message => _message;
  int? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}