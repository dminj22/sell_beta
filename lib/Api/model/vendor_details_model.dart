// To parse this JSON data, do
//
//     final vendorDetailModel = vendorDetailModelFromJson(jsonString);

import 'dart:convert';

VendorDetailModel vendorDetailModelFromJson(String str) => VendorDetailModel.fromJson(json.decode(str));

String vendorDetailModelToJson(VendorDetailModel data) => json.encode(data.toJson());

class VendorDetailModel {
  VendorDetailModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory VendorDetailModel.fromJson(Map<String, dynamic> json) => VendorDetailModel(
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
    this.name,
    this.email,
    this.company,
    this.address,
    this.ratingTotal,
    this.logo,
    this.vendorFollowerCount,
  });

  String? name;
  String? email;
  String? company;
  String? address;
  String? ratingTotal;
  String? logo;
  int? vendorFollowerCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    company: json["company"] == null ? null : json["company"],
    address: json["address"] == null ? null : json["address"],
    ratingTotal: json["rating_total"] == null ? null : json["rating_total"],
    logo: json["logo"] == null ? null : json["logo"],
    vendorFollowerCount: json["vendorFollowerCount"] == null ? null : json["vendorFollowerCount"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "company": company == null ? null : company,
    "address": address == null ? null : address,
    "rating_total": ratingTotal == null ? null : ratingTotal,
    "logo": logo == null ? null : logo,
    "vendorFollowerCount": vendorFollowerCount == null ? null : vendorFollowerCount,
  };
}
