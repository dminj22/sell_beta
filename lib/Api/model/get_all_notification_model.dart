// To parse this JSON data, do
//
//     final getAllNotificationModel = getAllNotificationModelFromJson(jsonString);

import 'dart:convert';

GetAllNotificationModel getAllNotificationModelFromJson(String str) => GetAllNotificationModel.fromJson(json.decode(str));

String getAllNotificationModelToJson(GetAllNotificationModel data) => json.encode(data.toJson());

class GetAllNotificationModel {
  GetAllNotificationModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  List<Datum>? data;

  factory GetAllNotificationModel.fromJson(Map<String, dynamic> json) => GetAllNotificationModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.adminId,
    this.userId,
    this.type,
    this.image,
    this.imageUrl,
    this.subject,
    this.message,
    this.addonUrl,
    this.startDate,
    this.endDate,
    this.readAt,
    this.status,
    this.dateTime,
  });

  String? id;
  String? adminId;
  dynamic userId;
  String? type;
  String? image;
  String ?imageUrl;
  String? subject;
  String? message;
  dynamic addonUrl;
  dynamic startDate;
  dynamic endDate;
  String? readAt;
  String? status;
  DateTime? dateTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    adminId: json["admin_id"] == null ? null : json["admin_id"],
    userId: json["user_id"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
    imageUrl: json["image_url"] == null ? null : json["image_url"],
    subject: json["subject"] == null ? null : json["subject"],
    message: json["message"] == null ? null : json["message"],
    addonUrl: json["addon_url"],
    startDate: json["start_date"],
    endDate: json["end_date"],
    readAt: json["read_at"] == null ? null : json["read_at"],
    status: json["status"] == null ? null : json["status"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "admin_id": adminId == null ? null : adminId,
    "user_id": userId,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
    "image_url": imageUrl == null ? null : imageUrl,
    "subject": subject == null ? null : subject,
    "message": message == null ? null : message,
    "addon_url": addonUrl,
    "start_date": startDate,
    "end_date": endDate,
    "read_at": readAt == null ? null : readAt,
    "status": status == null ? null : status,
    "date_time": dateTime == null ? null : dateTime!.toIso8601String(),
  };
}
