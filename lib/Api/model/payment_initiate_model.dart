// To parse this JSON data, do
//
//     final paymentInitiateModel = paymentInitiateModelFromJson(jsonString);

import 'dart:convert';

PaymentInitiateModel paymentInitiateModelFromJson(String str) => PaymentInitiateModel.fromJson(json.decode(str));

String paymentInitiateModelToJson(PaymentInitiateModel data) => json.encode(data.toJson());

class PaymentInitiateModel {
  PaymentInitiateModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data ?data;

  factory PaymentInitiateModel.fromJson(Map<String, dynamic> json) => PaymentInitiateModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.authorizationUrl,
    this.accessCode,
    this.reference,
  });

  String? authorizationUrl;
  String? accessCode;
  String? reference;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    authorizationUrl: json["authorization_url"] == null ? null : json["authorization_url"],
    accessCode: json["access_code"] == null ? null : json["access_code"],
    reference: json["reference"] == null ? null : json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "authorization_url": authorizationUrl == null ? null : authorizationUrl,
    "access_code": accessCode == null ? null : accessCode,
    "reference": reference == null ? null : reference,
  };
}
