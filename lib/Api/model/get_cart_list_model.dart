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

  dynamic status;
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
    this.vendorId,
    this.productId,
    this.quantity,
    this.price,
    this.dateTime,
    this.status,
  });

  String? cartId;
  String? userId;
  String? vendorId;
  String? productId;
  String ?quantity;
  String? price;
  DateTime? dateTime;
  String ?status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId == null ? null : cartId,
    "user_id": userId == null ? null : userId,
    "vendor_id": vendorId == null ? null : vendorId,
    "product_id": productId == null ? null : productId,
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "date_time": dateTime == null ? null : dateTime!.toIso8601String(),
    "status": status == null ? null : status,
  };
}
