// To parse this JSON data, do
//
//     final forgetUpdatePasswordModel = forgetUpdatePasswordModelFromJson(jsonString);

import 'dart:convert';

ForgetUpdatePasswordModel forgetUpdatePasswordModelFromJson(String str) => ForgetUpdatePasswordModel.fromJson(json.decode(str));

String forgetUpdatePasswordModelToJson(ForgetUpdatePasswordModel data) => json.encode(data.toJson());

class ForgetUpdatePasswordModel {
  ForgetUpdatePasswordModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  bool? data;

  factory ForgetUpdatePasswordModel.fromJson(Map<String, dynamic> json) => ForgetUpdatePasswordModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : json["data"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data,
  };
}
