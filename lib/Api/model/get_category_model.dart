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

  bool? status;
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
    this.banner,
    this.catImgUrl,
    this.subcategoryList,
  });

  String? categoryId;
  String? categoryName;
  String? banner;
  String? catImgUrl;
  List<SubcategoryList>? subcategoryList;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryId: json["category_id"] == null ? null : json["category_id"],
    categoryName: json["category_name"] == null ? null : json["category_name"],
    banner: json["banner"] == null ? null : json["banner"],
    catImgUrl: json["cat_img_url"] == null ? null : json["cat_img_url"],
    subcategoryList: json["subcategory_list"] == null ? null : List<SubcategoryList>.from(json["subcategory_list"].map((x) => SubcategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId == null ? null : categoryId,
    "category_name": categoryName == null ? null : categoryName,
    "banner": banner == null ? null : banner,
    "cat_img_url": catImgUrl == null ? null : catImgUrl,
    "subcategory_list": subcategoryList == null ? null : List<dynamic>.from(subcategoryList!.map((x) => x.toJson())),
  };
}

class SubcategoryList {
  SubcategoryList({
    this.subCategoryId,
    this.subCategoryName,
    this.category,
    this.banner,
    this.subCatImgUrl,
  });

  String? subCategoryId;
  String? subCategoryName;
  String? category;
  String? banner;
  String? subCatImgUrl;

  factory SubcategoryList.fromJson(Map<String, dynamic> json) => SubcategoryList(
    subCategoryId: json["sub_category_id"] == null ? null : json["sub_category_id"],
    subCategoryName: json["sub_category_name"] == null ? null : json["sub_category_name"],
    category: json["category"] == null ? null : json["category"],
    banner: json["banner"] == null ? null : json["banner"],
    subCatImgUrl: json["sub_cat_img_url"] == null ? null : json["sub_cat_img_url"],
  );

  Map<String, dynamic> toJson() => {
    "sub_category_id": subCategoryId == null ? null : subCategoryId,
    "sub_category_name": subCategoryName == null ? null : subCategoryName,
    "category": category == null ? null : category,
    "banner": banner == null ? null : banner,
    "sub_cat_img_url": subCatImgUrl == null ? null : subCatImgUrl,
  };
}
