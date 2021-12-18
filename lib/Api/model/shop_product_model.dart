// To parse this JSON data, do
//
//     final shopProductModel = shopProductModelFromJson(jsonString);

import 'dart:convert';

ShopProductModel shopProductModelFromJson(String str) => ShopProductModel.fromJson(json.decode(str));

String shopProductModelToJson(ShopProductModel data) => json.encode(data.toJson());

class ShopProductModel {
  ShopProductModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  List<Datum>? data;

  factory ShopProductModel.fromJson(Map<String, dynamic> json) => ShopProductModel(
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
    this.productId,
    this.type,
    this.vendorId,
    this.ratingNum,
    this.ratingTotal,
    this.ratingUser,
    this.title,
    this.category,
    this.subCategory,
    this.brand,
    this.description,
    this.numOfImgs,
    this.salePrice,
    this.salePriceCurrency,
    this.purchasePrice,
    this.purchasePriceCurrency,
    this.shippingCost,
    this.shippingCostCurrency,
    this.currentStock,
    this.unit,
    this.tag,
    this.discount,
    this.discountType,
    this.color,
    this.deliveryType,
    this.size,
    this.dateTime,
    this.imgUrl,
  });

  String? productId;
  String? type;
  String? vendorId;
  String? ratingNum;
  String? ratingTotal;
  String? ratingUser;
  String? title;
  String? category;
  String? subCategory;
  String? brand;
  String? description;
  dynamic numOfImgs;
  String? salePrice;
  String? salePriceCurrency;
  String? purchasePrice;
  String? purchasePriceCurrency;
  String? shippingCost;
  String? shippingCostCurrency;
  dynamic currentStock;
  String? unit;
  String? tag;
  String? discount;
  String? discountType;
  String? color;
  String? deliveryType;
  String? size;
  DateTime? dateTime;
  String? imgUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    productId: json["product_id"] == null ? null : json["product_id"],
    type: json["type"] == null ? null : json["type"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    ratingNum: json["rating_num"] == null ? null : json["rating_num"],
    ratingTotal: json["rating_total"] == null ? null : json["rating_total"],
    ratingUser: json["rating_user"] == null ? null : json["rating_user"],
    title: json["title"] == null ? null : json["title"],
    category: json["category"] == null ? null : json["category"],
    subCategory: json["sub_category"] == null ? null : json["sub_category"],
    brand: json["brand"] == null ? null : json["brand"],
    description: json["description"] == null ? null : json["description"],
    numOfImgs: json["num_of_imgs"],
    salePrice: json["sale_price"] == null ? null : json["sale_price"],
    salePriceCurrency: json["sale_price_currency"] == null ? null : json["sale_price_currency"],
    purchasePrice: json["purchase_price"] == null ? null : json["purchase_price"],
    purchasePriceCurrency: json["purchase_price_currency"] == null ? null : json["purchase_price_currency"],
    shippingCost: json["shipping_cost"] == null ? null : json["shipping_cost"],
    shippingCostCurrency: json["shipping_cost_currency"] == null ? null : json["shipping_cost_currency"],
    currentStock: json["current_stock"],
    unit: json["unit"] == null ? null : json["unit"],
    tag: json["tag"] == null ? null : json["tag"],
    discount: json["discount"] == null ? null : json["discount"],
    discountType: json["discount_type"] == null ? null : json["discount_type"],
    color: json["color"] == null ? null : json["color"],
    deliveryType: json["delivery_type"] == null ? null : json["delivery_type"],
    size: json["size"] == null ? null : json["size"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    imgUrl: json["img_url"] == null ? null : json["img_url"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "type": type == null ? null : type,
    "vendor_id": vendorId == null ? null : vendorId,
    "rating_num": ratingNum == null ? null : ratingNum,
    "rating_total": ratingTotal == null ? null : ratingTotal,
    "rating_user": ratingUser == null ? null : ratingUser,
    "title": title == null ? null : title,
    "category": category == null ? null : category,
    "sub_category": subCategory == null ? null : subCategory,
    "brand": brand == null ? null : brand,
    "description": description == null ? null : description,
    "num_of_imgs": numOfImgs,
    "sale_price": salePrice == null ? null : salePrice,
    "sale_price_currency": salePriceCurrency == null ? null : salePriceCurrency,
    "purchase_price": purchasePrice == null ? null : purchasePrice,
    "purchase_price_currency": purchasePriceCurrency == null ? null : purchasePriceCurrency,
    "shipping_cost": shippingCost == null ? null : shippingCost,
    "shipping_cost_currency": shippingCostCurrency == null ? null : shippingCostCurrency,
    "current_stock": currentStock,
    "unit": unit == null ? null : unit,
    "tag": tag == null ? null : tag,
    "discount": discount == null ? null : discount,
    "discount_type": discountType == null ? null : discountType,
    "color": color == null ? null : color,
    "delivery_type": deliveryType == null ? null : deliveryType,
    "size": size == null ? null : size,
    "date_time": dateTime == null ? null : dateTime!.toIso8601String(),
    "img_url": imgUrl == null ? null : imgUrl,
  };
}
