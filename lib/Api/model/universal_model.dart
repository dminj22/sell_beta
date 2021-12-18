// To parse this JSON data, do
//
//     final universalModel = universalModelFromJson(jsonString);

import 'dart:convert';

UniversalModel universalModelFromJson(String str) => UniversalModel.fromJson(json.decode(str));

String universalModelToJson(UniversalModel data) => json.encode(data.toJson());

class UniversalModel {
  UniversalModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  int? data;

  factory UniversalModel.fromJson(Map<String, dynamic> json) => UniversalModel(
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
