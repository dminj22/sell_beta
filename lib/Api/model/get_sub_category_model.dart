// To parse this JSON data, do
//
//     final getSubCategoryModel = getSubCategoryModelFromJson(jsonString);

import 'dart:convert';

GetSubCategoryModel getSubCategoryModelFromJson(String str) =>
    GetSubCategoryModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(GetSubCategoryModel data) =>
    json.encode(data.toJson());

class GetSubCategoryModel {
  GetSubCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  List<Datum>? data;

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.subCategoryId,
    this.subCategoryName,
    this.category,
    this.brand,
    this.digital,
    this.banner,
    this.subCatImgUrl,
    this.affiliation,
    this.affiliationPoints,
  });

  String? subCategoryId;
  String? subCategoryName;
  String? category;
  String? brand;
  dynamic digital;
  String? banner;
  String? subCatImgUrl;
  String? affiliation;
  String? affiliationPoints;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        subCategoryName: json["sub_category_name"] == null
            ? null
            : json["sub_category_name"],
        category: json["category"] == null ? null : json["category"],
        brand: json["brand"] == null ? null : json["brand"],
        digital: json["digital"],
        banner: json["banner"] == null ? null : json["banner"],
        subCatImgUrl:
            json["sub_cat_img_url"] == null ? null : json["sub_cat_img_url"],
        affiliation: json["affiliation"] == null ? null : json["affiliation"],
        affiliationPoints: json["affiliation_points"] == null
            ? null
            : json["affiliation_points"],
      );

  Map<String, dynamic> toJson() => {
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "sub_category_name": subCategoryName == null ? null : subCategoryName,
        "category": category == null ? null : category,
        "brand": brand == null ? null : brand,
        "digital": digital,
        "banner": banner == null ? null : banner,
        "sub_cat_img_url": subCatImgUrl == null ? null : subCatImgUrl,
        "affiliation": affiliation == null ? null : affiliation,
        "affiliation_points":
            affiliationPoints == null ? null : affiliationPoints,
      };
}
