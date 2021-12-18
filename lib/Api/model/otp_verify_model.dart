// To parse this JSON data, do
//
//     final otpVerifyModel = otpVerifyModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyModel otpVerifyModelFromJson(String str) => OtpVerifyModel.fromJson(json.decode(str));

String otpVerifyModelToJson(OtpVerifyModel data) => json.encode(data.toJson());

class OtpVerifyModel {
  OtpVerifyModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  Data? data;

  factory OtpVerifyModel.fromJson(Map<String, dynamic> json) => OtpVerifyModel(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.userId,
    this.username,
    this.surname,
    this.email,
    this.phone,
    this.address1,
    this.country,
    this.state,
    this.city,
    this.zip,
    this.profilePhoto,
    this.profilePhotoUrl,
    this.langlat,
    this.password,
    this.fbId,
    this.gId,
    this.gPhoto,
    this.creationDate,
    this.googlePlus,
    this.skype,
    this.facebook,
    this.wishlist,
    this.lastLogin,
    this.userType,
    this.userTypeTill,
    this.leftProductType,
    this.downloads,
    this.wallet,
    this.productUpload,
    this.packageInfo,
    this.status,
    this.otp,
    this.dateTime,
  });

  String? userId;
  String? username;
  dynamic surname;
  String? email;
  dynamic phone;
  dynamic address1;
  String? country;
  String? state;
  String? city;
  String? zip;
  String? profilePhoto;
  String? profilePhotoUrl;
  dynamic langlat;
  String? password;
  dynamic fbId;
  dynamic gId;
  dynamic gPhoto;
  dynamic creationDate;
  dynamic googlePlus;
  dynamic skype;
  dynamic facebook;
  dynamic wishlist;
  dynamic lastLogin;
  String? userType;
  dynamic userTypeTill;
  String? leftProductType;
  String? downloads;
  String? wallet;
  dynamic productUpload;
  dynamic packageInfo;
  String ?status;
  String ?otp;
  DateTime? dateTime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"] == null ? null : json["user_id"],
    username: json["username"] == null ? null : json["username"],
    surname: json["surname"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"],
    address1: json["address1"],
    country: json["country"] == null ? null : json["country"],
    state: json["state"] == null ? null : json["state"],
    city: json["city"] == null ? null : json["city"],
    zip: json["zip"] == null ? null : json["zip"],
    profilePhoto: json["profile_photo"] == null ? null : json["profile_photo"],
    profilePhotoUrl: json["profile_photo_url"] == null ? null : json["profile_photo_url"],
    langlat: json["langlat"],
    password: json["password"] == null ? null : json["password"],
    fbId: json["fb_id"],
    gId: json["g_id"],
    gPhoto: json["g_photo"],
    creationDate: json["creation_date"],
    googlePlus: json["google_plus"],
    skype: json["skype"],
    facebook: json["facebook"],
    wishlist: json["wishlist"],
    lastLogin: json["last_login"],
    userType: json["user_type"] == null ? null : json["user_type"],
    userTypeTill: json["user_type_till"],
    leftProductType: json["left_product_type"] == null ? null : json["left_product_type"],
    downloads: json["downloads"] == null ? null : json["downloads"],
    wallet: json["wallet"] == null ? null : json["wallet"],
    productUpload: json["product_upload"],
    packageInfo: json["package_info"],
    status: json["status"] == null ? null : json["status"],
    otp: json["otp"] == null ? null : json["otp"],
    dateTime: json["date_time"] == null ? null : DateTime.parse(json["date_time"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId == null ? null : userId,
    "username": username == null ? null : username,
    "surname": surname,
    "email": email == null ? null : email,
    "phone": phone,
    "address1": address1,
    "country": country == null ? null : country,
    "state": state == null ? null : state,
    "city": city == null ? null : city,
    "zip": zip == null ? null : zip,
    "profile_photo": profilePhoto == null ? null : profilePhoto,
    "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
    "langlat": langlat,
    "password": password == null ? null : password,
    "fb_id": fbId,
    "g_id": gId,
    "g_photo": gPhoto,
    "creation_date": creationDate,
    "google_plus": googlePlus,
    "skype": skype,
    "facebook": facebook,
    "wishlist": wishlist,
    "last_login": lastLogin,
    "user_type": userType == null ? null : userType,
    "user_type_till": userTypeTill,
    "left_product_type": leftProductType == null ? null : leftProductType,
    "downloads": downloads == null ? null : downloads,
    "wallet": wallet == null ? null : wallet,
    "product_upload": productUpload,
    "package_info": packageInfo,
    "status": status == null ? null : status,
    "otp": otp == null ? null : otp,
    "date_time": dateTime == null ? null : dateTime!.toIso8601String(),
  };
}
