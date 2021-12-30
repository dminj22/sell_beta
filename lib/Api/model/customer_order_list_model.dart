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
    this.vendorId,
    this.userId,
    this.productId,
    this.addressId,
    this.quantity,
    this.amount,
    this.totalAmount,
    this.taxCharge,
    this.shippingCharge,
    this.coupon,
    this.noOfProduct,
    this.deliveryStatus,
    this.paymentStatus,
    this.paymentMethod,
    this.refund,
    this.orderDate,
    this.productList,
    this.vendorDetails,
    this.userDetails,
    this.shippingAddress,
  });

  String? orderId;
  String? orderCode;
  String? vendorId;
  String ?userId;
  String ?productId;
  String ?addressId;
  String ?quantity;
  String ?amount;
  String ?totalAmount;
  dynamic taxCharge;
  String? shippingCharge;
  String? coupon;
  String? noOfProduct;
  String? deliveryStatus;
  String? paymentStatus;
  String? paymentMethod;
  String? refund;
  DateTime? orderDate;
  List<ProductList>? productList;
  VendorDetails? vendorDetails;
  UserDetails? userDetails;
  ShippingAddress? shippingAddress;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    orderId: json["order_id "] == null ? null : json["order_id "],
    orderCode: json["order_code"] == null ? null : json["order_code"],
    vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
    userId: json["user_id "] == null ? null : json["user_id "],
    productId: json["product_id "] == null ? null : json["product_id "],
    addressId: json["address_id"] == null ? null : json["address_id"],
    quantity: json["quantity"] == null ? null : json["quantity"],
    amount: json["amount"] == null ? null : json["amount"],
    totalAmount: json["total_amount"] == null ? null : json["total_amount"],
    taxCharge: json["tax_charge"],
    shippingCharge: json["shipping_charge"] == null ? null : json["shipping_charge"],
    coupon: json["coupon"] == null ? null : json["coupon"],
    noOfProduct: json["no_of_product"] == null ? null : json["no_of_product"],
    deliveryStatus: json["delivery_status"] == null ? null : json["delivery_status"],
    paymentStatus: json["payment_status"] == null ? null : json["payment_status"],
    paymentMethod: json["payment_method"] == null ? null : json["payment_method"],
    refund: json["refund"] == null ? null : json["refund"],
    orderDate: json["order_date"] == null ? null : DateTime.parse(json["order_date"]),
    productList: json["product_list"] == null ? null : List<ProductList>.from(json["product_list"].map((x) => ProductList.fromJson(x))),
    vendorDetails: json["vendor_details"] == null ? null : VendorDetails.fromJson(json["vendor_details"]),
    userDetails: json["user_details"] == null ? null : UserDetails.fromJson(json["user_details"]),
    shippingAddress: json["shipping_address"] == null ? null : ShippingAddress.fromJson(json["shipping_address"]),
  );

  Map<String, dynamic> toJson() => {
    "order_id ": orderId == null ? null : orderId,
    "order_code": orderCode == null ? null : orderCode,
    "vendor_id": vendorId == null ? null : vendorId,
    "user_id ": userId == null ? null : userId,
    "product_id ": productId == null ? null : productId,
    "address_id": addressId == null ? null : addressId,
    "quantity": quantity == null ? null : quantity,
    "amount": amount == null ? null : amount,
    "total_amount": totalAmount == null ? null : totalAmount,
    "tax_charge": taxCharge,
    "shipping_charge": shippingCharge == null ? null : shippingCharge,
    "coupon": coupon == null ? null : coupon,
    "no_of_product": noOfProduct == null ? null : noOfProduct,
    "delivery_status": deliveryStatus == null ? null : deliveryStatus,
    "payment_status": paymentStatus == null ? null : paymentStatus,
    "payment_method": paymentMethod == null ? null : paymentMethod,
    "refund": refund == null ? null : refund,
    "order_date": orderDate == null ? null : "${orderDate!.year.toString().padLeft(4, '0')}-${orderDate!.month.toString().padLeft(2, '0')}-${orderDate!.day.toString().padLeft(2, '0')}",
    "product_list": productList == null ? null : List<dynamic>.from(productList!.map((x) => x.toJson())),
    "vendor_details": vendorDetails == null ? null : vendorDetails!.toJson(),
    "user_details": userDetails == null ? null : userDetails!.toJson(),
    "shipping_address": shippingAddress == null ? null : shippingAddress!.toJson(),
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

  String ?productId;
  String ?sku;
  String ?title;
  String ?description;
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

  factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
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

  String ?userId;
  String ?name;
  String ?email;
  String ?phone;
  String ?profileUrl;

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

  String ?vendorId;
  String ?name;
  String ?shopName;
  String ?phone;
  String ?address;
  String ?state;
  String ?city;
  String ?zip;
  String ?image;

  factory VendorDetails.fromJson(Map<String, dynamic> json) => VendorDetails(
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
