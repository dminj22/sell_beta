// To parse this JSON data, do
//
//     final getFeedsModel = getFeedsModelFromJson(jsonString);

import 'dart:convert';

GetFeedsModel getFeedsModelFromJson(String str) => GetFeedsModel.fromJson(json.decode(str));

String getFeedsModelToJson(GetFeedsModel data) => json.encode(data.toJson());

class GetFeedsModel {
  GetFeedsModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory GetFeedsModel.fromJson(Map<String, dynamic> json) => GetFeedsModel(
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
    this.feedsId,
    this.vendorId,
    this.feedTitle,
    this.feedDescription,
    this.feedLike,
    this.feedComment,
    this.isCustomerLiked,
    this.post,
    this.image,
    this.postType,
    this.productId,
    this.productList,
    this.vendorDetails,
  });

  String? feedsId;
  String? vendorId;
  String? feedTitle;
  String? feedDescription;
  String? feedLike;
  String? feedComment;
  bool? isCustomerLiked;
  String? post;
  List<Image>? image;
  String ?postType;
  String? productId;
  List<ProductList>? productList;
  VendorDetails? vendorDetails;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    feedsId: json["feeds_id"] == null ? null : json["feeds_id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    feedTitle: json["feed_title"] == null ? null : json["feed_title"],
    feedDescription: json["feed_description"] == null ? null : json["feed_description"],
    feedLike: json["feed_like"] == null ? null : json["feed_like"],
    feedComment: json["feed_comment"] == null ? null : json["feed_comment"],
    isCustomerLiked: json["is_customer_liked"] == null ? null : json["is_customer_liked"],
    post: json["post"] == null ? null : json["post"],
    image: json["image"] == null ? null : List<Image>.from(json["image"].map((x) => Image.fromJson(x))),
    postType: json["post_type"] == null ? null : json["post_type"],
    productId: json["product_id"] == null ? null : json["product_id"],
    productList: json["product_list"] == null ? null : List<ProductList>.from(json["product_list"].map((x) => ProductList.fromJson(x))),
    vendorDetails: json["vendor_details"] == null ? null : VendorDetails.fromJson(json["vendor_details"]),
  );

  Map<String, dynamic> toJson() => {
    "feeds_id": feedsId == null ? null : feedsId,
    "vendor_id": vendorId == null ? null : vendorId,
    "feed_title": feedTitle == null ? null : feedTitle,
    "feed_description": feedDescription == null ? null : feedDescription,
    "feed_like": feedLike == null ? null : feedLike,
    "feed_comment": feedComment == null ? null : feedComment,
    "is_customer_liked": isCustomerLiked == null ? null : isCustomerLiked,
    "post": post == null ? null : post,
    "image": image == null ? null : List<dynamic>.from(image!.map((x) => x.toJson())),
    "post_type": postType == null ? null : postType,
    "product_id": productId == null ? null : productId,
    "product_list": productList == null ? null : List<dynamic>.from(productList!.map((x) => x.toJson())),
    "vendor_details": vendorDetails == null ? null : vendorDetails!.toJson(),
  };
}

class Image {
  Image({
    this.url,
  });

  String? url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
  };
}

class ProductList {
  ProductList({
    this.productId,
    this.sku,
    this.title,
    this.description,
    this.salePrice,
    this.salePriceCurrency,
    this.image,
  });

  String? productId;
  String? sku;
  String? title;
  String? description;
  String? salePrice;
  String? salePriceCurrency;
  String? image;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    productId: json["product_id"] == null ? null : json["product_id"],
    sku: json["sku"] == null ? null : json["sku"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    salePrice: json["sale_price"] == null ? null : json["sale_price"],
    salePriceCurrency: json["sale_price_currency"] == null ? null : json["sale_price_currency"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "sku": sku == null ? null : sku,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "sale_price": salePrice == null ? null : salePrice,
    "sale_price_currency": salePriceCurrency == null ? null : salePriceCurrency,
    "image": image == null ? null : image,
  };
}

class VendorDetails {
  VendorDetails({
    this.vendorId,
    this.name,
    this.image,
  });

  String? vendorId;
  String? name;
  String? image;

  factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    name: json["name"] == null ? null : json["name"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId == null ? null : vendorId,
    "name": name == null ? null : name,
    "image": image == null ? null : image,
  };
}
