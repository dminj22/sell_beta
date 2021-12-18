// To parse this JSON data, do
//
//     final productReviewModel = productReviewModelFromJson(jsonString);

import 'dart:convert';

ProductReviewModel productReviewModelFromJson(String str) => ProductReviewModel.fromJson(json.decode(str));

String productReviewModelToJson(ProductReviewModel data) => json.encode(data.toJson());

class ProductReviewModel {
  ProductReviewModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) => ProductReviewModel(
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
    this.id,
    this.reviewsId,
    this.productId,
    this.userId,
    this.vendorId,
    this.file,
    this.fileUrl,
    this.rating,
    this.title,
    this.comment,
    this.likes,
    this.dislike,
    this.createdAt,
    this.username,
    this.profilePhotoUrl,
  });

  String? id;
  String? reviewsId;
  String? productId;
  String? userId;
  String? vendorId;
  String? file;
  String? fileUrl;
  String? rating;
  String? title;
  String? comment;
  String? likes;
  String? dislike;
  DateTime? createdAt;
  String ?username;
  String ?profilePhotoUrl;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    reviewsId: json["reviews_id"] == null ? null : json["reviews_id"],
    productId: json["product_id"] == null ? null : json["product_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    file: json["file"] == null ? null : json["file"],
    fileUrl: json["file_url"] == null ? null : json["file_url"],
    rating: json["rating"] == null ? null : json["rating"],
    title: json["title"] == null ? null : json["title"],
    comment: json["comment"] == null ? null : json["comment"],
    likes: json["likes"] == null ? null : json["likes"],
    dislike: json["dislike"] == null ? null : json["dislike"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    username: json["username"] == null ? null : json["username"],
    profilePhotoUrl: json["profile_photo_url"] == null ? null : json["profile_photo_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "reviews_id": reviewsId == null ? null : reviewsId,
    "product_id": productId == null ? null : productId,
    "user_id": userId == null ? null : userId,
    "vendor_id": vendorId == null ? null : vendorId,
    "file": file == null ? null : file,
    "file_url": fileUrl == null ? null : fileUrl,
    "rating": rating == null ? null : rating,
    "title": title == null ? null : title,
    "comment": comment == null ? null : comment,
    "likes": likes == null ? null : likes,
    "dislike": dislike == null ? null : dislike,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "username": username == null ? null : username,
    "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
  };
}
