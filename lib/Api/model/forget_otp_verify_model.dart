// To parse this JSON data, do
//
//     final forgetOtpVerifyModel = forgetOtpVerifyModelFromJson(jsonString);

import 'dart:convert';

ForgetOtpVerifyModel forgetOtpVerifyModelFromJson(String str) => ForgetOtpVerifyModel.fromJson(json.decode(str));

String forgetOtpVerifyModelToJson(ForgetOtpVerifyModel data) => json.encode(data.toJson());

class ForgetOtpVerifyModel {
  ForgetOtpVerifyModel({
    this.status,
    this.message,
  });

  dynamic status;
  String? message;

  factory ForgetOtpVerifyModel.fromJson(Map<String, dynamic> json) => ForgetOtpVerifyModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
