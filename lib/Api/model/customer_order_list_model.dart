// To parse this JSON data, do
//
//     final customerOrderListModel = customerOrderListModelFromJson(jsonString);

import 'dart:convert';

CustomerOrderListModel customerOrderListModelFromJson(String str) => CustomerOrderListModel.fromJson(json.decode(str));

String customerOrderListModelToJson(CustomerOrderListModel data) => json.encode(data.toJson());

class CustomerOrderListModel {
  CustomerOrderListModel({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory CustomerOrderListModel.fromJson(Map<String, dynamic> json) => CustomerOrderListModel(
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
    this.orderId,
    this.orderCode,
    this.cartId,
    this.userId,
    this.addressId,
    this.deliveryStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.orderDate,
    this.cartDetail,
    this.productDetail,
    this.vendorDetail,
    this.userDetail,
    this.shippingDetail,
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
  CartDetail? cartDetail;
  ProductDetail? productDetail;
  VendorDetail? vendorDetail;
  UserDetail? userDetail;
  ShippingDetail? shippingDetail;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderId: json["order_id "] == null ? null : json["order_id "],
    orderCode: json["order_code"] == null ? null : json["order_code"],
    cartId: json["cart_id"] == null ? null : json["cart_id"],
    userId: json["user_id "] == null ? null : json["user_id "],
    addressId: json["address_id"] == null ? null : json["address_id"],
    deliveryStatus: json["delivery_status"] == null ? null : json["delivery_status"],
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    cartDetail: json["cart__detail"] == null ? null : CartDetail.fromJson(json["cart__detail"]),
    productDetail: json["product_detail"] == null ? null : ProductDetail.fromJson(json["product_detail"]),
    vendorDetail: json["vendor_detail"] == null ? null : VendorDetail.fromJson(json["vendor_detail"]),
    userDetail: json["user_detail"] == null ? null : UserDetail.fromJson(json["user_detail"]),
    shippingDetail: json["shipping_detail"] == null ? null : ShippingDetail.fromJson(json["shipping_detail"]),
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
    "order_date": orderDate == null ? null : "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate?.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
    "cart__detail": cartDetail == null ? null : cartDetail!.toJson(),
    "product_detail": productDetail == null ? null : productDetail!.toJson(),
    "vendor_detail": vendorDetail == null ? null : vendorDetail!.toJson(),
    "user_detail": userDetail == null ? null : userDetail?.toJson(),
    "shipping_detail": shippingDetail == null ? null : shippingDetail?.toJson(),
  };
}

class CartDetail {
  CartDetail({
    this.cartId,
    this.productId,
    this.vendorId,
    this.userId,
    this.quantity,
    this.price,
    this.size,
    this.color,
  });

  String? cartId;
  String ?productId;
  String ?vendorId;
  String ?userId;
  String ?quantity;
  String ?price;
  String ?size;
  String ?color;

  factory CartDetail.fromJson(Map<String, dynamic> json) => CartDetail(
    cartId: json["cart_id "] == null ? null : json["cart_id "],
    productId: json["product_id"] == null ? null : json["product_id"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    userId: json["user_id "] == null ? null : json["user_id "],
    quantity: json["quantity"] == null ? null : json["quantity"],
    price: json["price"] == null ? null : json["price"],
    size: json["size"] == null ? null : json["size"],
    color: json["color"] == null ? null : json["color"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id ": cartId == null ? null : cartId,
    "product_id": productId == null ? null : productId,
    "vendor_id": vendorId == null ? null : vendorId,
    "user_id ": userId == null ? null : userId,
    "quantity": quantity == null ? null : quantity,
    "price": price == null ? null : price,
    "size": size == null ? null : size,
    "color": color == null ? null : color,
  };
}

class ProductDetail {
  ProductDetail({
    this.productId,
    this.sku,
    this.title,
    this.brandName,
    this.description,
    this.salePrice,
    this.salePriceCurrency,
    this.image,
  });

  String? productId;
  String? sku;
  String? title;
  String? brandName;
  String? description;
  String? salePrice;
  String? salePriceCurrency;
  String? image;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: json["product_id"] == null ? null : json["product_id"],
    sku: json["sku"] == null ? null : json["sku"],
    title: json["title"] == null ? null : json["title"],
    brandName: json["brand_name"] == null ? null : json["brand_name"],
    description: json["description"] == null ? null : json["description"],
    salePrice: json["sale_price"] == null ? null : json["sale_price"],
    salePriceCurrency: json["sale_price_currency"] == null ? null : json["sale_price_currency"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId == null ? null : productId,
    "sku": sku == null ? null : sku,
    "title": title == null ? null : title,
    "brand_name": brandName == null ? null : brandName,
    "description": description == null ? null : description,
    "sale_price": salePrice == null ? null : salePrice,
    "sale_price_currency": salePriceCurrency == null ? null : salePriceCurrency,
    "image": image == null ? null : image,
  };
}

class ShippingDetail {
  ShippingDetail({
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

  String ?addressId;
  String ?userId;
  String ?stateName;
  String ?cityName;
  String ?fullName;
  String ?email;
  String ?address;
  String ?area;
  String ?zip;
  String ?mobileNo;

  factory ShippingDetail.fromJson(Map<String, dynamic> json) => ShippingDetail(
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

class UserDetail {
  UserDetail({
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

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
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

class VendorDetail {
  VendorDetail({
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

  String? vendorId;
  String? name;
  String? shopName;
  String? phone;
  String? address;
  String? state;
  String? city;
  String? zip;
  String? image;

  factory VendorDetail.fromJson(Map<String, dynamic> json) => VendorDetail(
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    name: json["name"] == null ? null : json["name"],
    shopName: json["shop_name"] == null ? null : json["shop_name"],
    phone: json["phone"] == null ? null : json["phone"],
    address: json["address"] == null ? null : json["address"],
    state: json["state"] == null ? null : json["state"],
    city: json["city"] == null ? null : json["city"],
    zip: json["zip"] == null ? null : json["zip"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId == null ? null : vendorId,
    "name": name == null ? null : name,
    "shop_name": shopName == null ? null : shopName,
    "phone": phone == null ? null : phone,
    "address": address == null ? null : address,
    "state": state == null ? null : state,
    "city": city == null ? null : city,
    "zip": zip == null ? null : zip,
    "image": image == null ? null : image,
  };
}
