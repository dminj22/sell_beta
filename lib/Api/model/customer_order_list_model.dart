// To parse this JSON data, do
//
//     final customerOrderListModel = customerOrderListModelFromJson(jsonString);

import 'dart:convert';

CustomerOrderListModel customerOrderListModelFromJson(String str) =>
    CustomerOrderListModel.fromJson(json.decode(str));

String customerOrderListModelToJson(CustomerOrderListModel data) =>
    json.encode(data.toJson());

class CustomerOrderListModel {
  CustomerOrderListModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory CustomerOrderListModel.fromJson(Map<String, dynamic> json) =>
      CustomerOrderListModel(
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
    this.orderId,
    this.orderCode,
    this.cartId,
    this.userId,
    this.addressId,
    this.deliveryStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.orderDate,
    this.productList,
    this.vendorDetails,
    this.userDetails,
    this.shippingAddress,
  });

  String? orderId;
  String? orderCode;
  String? cartId;
  String? userId;
  String? addressId;
  String? deliveryStatus;
  String? paymentStatus;
  String? paymentMethod;
  DateTime? orderDate;
  List<dynamic>? productList;
  VendorDetails? vendorDetails;
  UserDetails? userDetails;
  ShippingAddress? shippingAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        orderId: json["order_id "] == null ? null : json["order_id "],
        orderCode: json["order_code"] == null ? null : json["order_code"],
        cartId: json["cart_id"] == null ? null : json["cart_id"],
        userId: json["user_id "] == null ? null : json["user_id "],
        addressId: json["address_id"] == null ? null : json["address_id"],
        deliveryStatus:
            json["delivery_status"] == null ? null : json["delivery_status"],
        paymentStatus:
            json["payment_status"] == null ? null : json["payment_status"],
        paymentMethod:
            json["payment_method"] == null ? null : json["payment_method"],
        orderDate: json["order_date"] == null
            ? null
            : DateTime.parse(json["order_date"]),
        productList: json["product_list"] == null
            ? null
            : List<dynamic>.from(json["product_list"].map((x) => x)),
        vendorDetails: json["vendor_details"] == null
            ? null
            : VendorDetails.fromJson(json["vendor_details"]),
        userDetails: json["user_details"] == null
            ? null
            : UserDetails.fromJson(json["user_details"]),
        shippingAddress: json["shipping_address"] == null
            ? null
            : ShippingAddress.fromJson(json["shipping_address"]),
      );

  Map<String, dynamic> toJson() => {
        "order_id ": orderId == null ? null : orderId,
        "order_code": orderCode == null ? null : orderCode,
        "cart_id": cartId == null ? null : cartId,
        "user_id ": userId == null ? null : userId,
        "address_id": addressId == null ? null : addressId,
        "delivery_status": deliveryStatus == null ? null : deliveryStatus,
        "payment_status": paymentStatus == null ? null : paymentStatus,
        "payment_method": paymentMethod == null ? null : paymentMethod,
        "order_date": orderDate == null
            ? null
            : "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
        "product_list": productList == null
            ? null
            : List<dynamic>.from(productList!.map((x) => x)),
        "vendor_details":
            vendorDetails == null ? null : vendorDetails!.toJson(),
        "user_details": userDetails == null ? null : userDetails!.toJson(),
        "shipping_address":
            shippingAddress == null ? null : shippingAddress!.toJson(),
      };
}

class ShippingAddress {
  ShippingAddress({
    this.addressId,
    this.userId,
    this.stateName,
    this.cityName,
    this.fullName,
    this.email,
    this.address,
    this.area,
    this.zip,
    this.mobileNo,
  });

  String? addressId;
  String? userId;
  String? stateName;
  String? cityName;
  String? fullName;
  String? email;
  String? address;
  String? area;
  String? zip;
  String? mobileNo;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        addressId: json["address_id"] == null ? null : json["address_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        stateName: json["state_name"] == null ? null : json["state_name"],
        cityName: json["city_name"] == null ? null : json["city_name"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        email: json["email"] == null ? null : json["email"],
        address: json["address"] == null ? null : json["address"],
        area: json["area"] == null ? null : json["area"],
        zip: json["zip"] == null ? null : json["zip"],
        mobileNo: json["mobile_no"] == null ? null : json["mobile_no"],
      );

  Map<String, dynamic> toJson() => {
        "address_id": addressId == null ? null : addressId,
        "user_id": userId == null ? null : userId,
        "state_name": stateName == null ? null : stateName,
        "city_name": cityName == null ? null : cityName,
        "full_name": fullName == null ? null : fullName,
        "email": email == null ? null : email,
        "address": address == null ? null : address,
        "area": area == null ? null : area,
        "zip": zip == null ? null : zip,
        "mobile_no": mobileNo == null ? null : mobileNo,
      };
}

class UserDetails {
  UserDetails({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.profileUrl,
  });

  String? userId;
  String? name;
  String? email;
  String? phone;
  String? profileUrl;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        profileUrl: json["profile_url"] == null ? null : json["profile_url"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "profile_url": profileUrl == null ? null : profileUrl,
      };
}

class VendorDetails {
  VendorDetails({
    this.vendorId,
    this.name,
    this.shopName,
    this.phone,
    this.address,
    this.state,
    this.city,
    this.zip,
    this.image,
  });

  dynamic vendorId;
  dynamic name;
  dynamic shopName;
  dynamic phone;
  dynamic address;
  dynamic state;
  dynamic city;
  dynamic zip;
  String? image;

  factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
        vendorId: json["vendor_id"],
        name: json["name"],
        shopName: json["shop_name"],
        phone: json["phone"],
        address: json["address"],
        state: json["state"],
        city: json["city"],
        zip: json["zip"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "name": name,
        "shop_name": shopName,
        "phone": phone,
        "address": address,
        "state": state,
        "city": city,
        "zip": zip,
        "image": image == null ? null : image,
      };
}
