// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
  GetCategoryModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  List<Datum>? data;

  factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
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
    this.categoryId,
    this.categoryName,
    this.description,
    this.digital,
    this.banner,
    this.catImgUrl,
    this.dataBrands,
    this.dataVendors,
    this.dataSubdets,
  });

  String? categoryId;
  String? categoryName;
  dynamic description;
  String? digital;
  String? banner;
  String? catImgUrl;
  String? dataBrands;
  String? dataVendors;
  String? dataSubdets;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryId: json["category_id"] == null ? null : json["category_id"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    description: json["description"],
    digital: json["digital"] == null ? null : json["digital"],
    banner: json["banner"] == null ? null : json["banner"],
    catImgUrl: json["cat_img_url"] == null ? null : json["cat_img_url"],
    dataBrands: json["data_brands"] == null ? null : json["data_brands"],
    dataVendors: json["data_vendors"] == null ? null : json["data_vendors"],
    dataSubdets: json["data_subdets"] == null ? null : json["data_subdets"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId == null ? null : categoryId,
    "category_name": categoryName == null ? null : categoryName,
    "description": description,
    "digital": digital == null ? null : digital,
    "banner": banner == null ? null : banner,
    "cat_img_url": catImgUrl == null ? null : catImgUrl,
    "data_brands": dataBrands == null ? null : dataBrands,
    "data_vendors": dataVendors == null ? null : dataVendors,
    "data_subdets": dataSubdets == null ? null : dataSubdets,
  };
}
