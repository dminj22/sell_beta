// To parse this JSON data, do
//
//     final singleViewProductImageModel = singleViewProductImageModelFromJson(jsonString);

import 'dart:convert';

SingleViewProductImageModel singleViewProductImageModelFromJson(String str) => SingleViewProductImageModel.fromJson(json.decode(str));

String singleViewProductImageModelToJson(SingleViewProductImageModel data) => json.encode(data.toJson());

class SingleViewProductImageModel {
  SingleViewProductImageModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String ?message;
  List<Datum>? data;

  factory SingleViewProductImageModel.fromJson(Map<String, dynamic> json) => SingleViewProductImageModel(
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
    this.productId,
    this.images,
    this.imgUrl,
    this.dateTime,
  });

  String? id;
  String? productId;
  String? images;
  String ?imgUrl;
  DateTime ?dateTime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    images: json["images"] == null ? null : json["images"],
    imgUrl: json["img_url"] == null ? null : json["img_url"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "product_id": productId == null ? null : productId,
    "images": images == null ? null : images,
    "img_url": imgUrl == null ? null : imgUrl,
    "date_time": dateTime == null ? null : dateTime!.toIso8601String(),
  };
}
