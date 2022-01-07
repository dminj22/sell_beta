// To parse this JSON data, do
//
//     final getCartListModel = getCartListModelFromJson(jsonString);

import 'dart:convert';

GetCartListModel getCartListModelFromJson(String str) => GetCartListModel.fromJson(json.decode(str));

String getCartListModelToJson(GetCartListModel data) => json.encode(data.toJson());

class GetCartListModel {
  GetCartListModel({
    this.status,
    this.message,
    this.data,
  });

  bool ?status;
  String? message;
  List<Datum>? data;

  factory GetCartListModel.fromJson(Map<String, dynamic> json) => GetCartListModel(
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
    this.cartId,
    this.userId,
    this.username,
    this.userPrfileImg,
    this.vendorShopName,
    this.vendorShopLogo,
    this.productId,
    this.quantity,
    this.size,
    this.color,
    this.addedOn,
    this.productList,
  });

  String ?cartId;
  String ?userId;
  String ?username;
  String ?userPrfileImg;
  String ?vendorShopName;
  String ?vendorShopLogo;
  String ?productId;
  String ?quantity;
  String ?size;
  String ?color;
  DateTime ?addedOn;
  ProductList ?productList;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : json["username"],
    userPrfileImg: json["user_prfile_img"] == null ? null : json["user_prfile_img"],
    vendorShopName: json["vendor_shop_name"] == null ? null : json["vendor_shop_name"],
    vendorShopLogo: json["vendor_shop_logo"] == null ? null : json["vendor_shop_logo"],
    productId: json["product_id"] == null ? null : json["product_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    size: json["size"] == null ? null : json["size"],
    color: json["color"] == null ? null : json["color"],
    addedOn: json["added_on"] == null ? null : DateTime.parse(json["added_on"]),
    productList: json["product_list"] == null ? null : ProductList.fromJson(json["product_list"]),
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId == null ? null : cartId,
    "user_id": userId == null ? null : userId,
    "username": username == null ? null : username,
    "user_prfile_img": userPrfileImg == null ? null : userPrfileImg,
    "vendor_shop_name": vendorShopName == null ? null : vendorShopName,
    "vendor_shop_logo": vendorShopLogo == null ? null : vendorShopLogo,
    "product_id": productId == null ? null : productId,
    "quantity": quantity == null ? null : quantity,
    "size": size == null ? null : size,
    "color": color == null ? null : color,
    "added_on": addedOn == null ? null : addedOn!.toIso8601String(),
    "product_list": productList == null ? null : productList!.toJson(),
  };
}

class ProductList {
  ProductList({
    this.productId,
    this.sku,
    this.title,
    this.brandName,
    this.description,
    this.salePrice,
    this.salePriceCurrency,
    this.thumbImage,
  });

  String? productId;
  String? sku;
  String? title;
  String? brandName;
  String? description;
  String? salePrice;
  String? salePriceCurrency;
  String? thumbImage;

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    productId: json["product_id"] == null ? null : json["product_id"],
    sku: json["sku"] == null ? null : json["sku"],
    title: json["title"] == null ? null : json["title"],
    brandName: json["brand_name"] == null ? null : json["brand_name"],
    description: json["description"] == null ? null : json["description"],
    salePrice: json["sale_price"] == null ? null : json["sale_price"],
    salePriceCurrency: json["sale_price_currency"] == null ? null : json["sale_price_currency"],
    thumbImage: json["thumb_image"] == null ? null : json["thumb_image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "sku": sku == null ? null : sku,
    "title": title == null ? null : title,
    "brand_name": brandName == null ? null : brandName,
    "description": description == null ? null : description,
    "sale_price": salePrice == null ? null : salePrice,
    "sale_price_currency": salePriceCurrency == null ? null : salePriceCurrency,
    "thumb_image": thumbImage == null ? null : thumbImage,
  };
}
