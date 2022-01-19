import 'dart:convert';
/// status : true
/// message : "Payment success"
/// data : 10

VerificationPaymentModel verificationPaymentModelFromJson(String str) => VerificationPaymentModel.fromJson(json.decode(str));
String verificationPaymentModelToJson(VerificationPaymentModel data) => json.encode(data.toJson());
class VerificationPaymentModel {
  VerificationPaymentModel({
      bool? status, 
      String? message, 
      int? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  VerificationPaymentModel.fromJson(dynamic json) {
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