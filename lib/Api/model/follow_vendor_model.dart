import 'dart:convert';
/// status : true
/// message : "Shop follow successfully"
/// data : true

FollowVendorModel followVendorModelFromJson(String str) => FollowVendorModel.fromJson(json.decode(str));
String followVendorModelToJson(FollowVendorModel data) => json.encode(data.toJson());
class FollowVendorModel {
  FollowVendorModel({
      bool? status, 
      String? message, 
      bool? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  FollowVendorModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
  }
  bool? _status;
  String? _message;
  bool? _data;

  bool? get status => _status;
  String? get message => _message;
  bool? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }

}