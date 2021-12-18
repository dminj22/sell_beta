// To parse this JSON data, do
//
//     final singleProductViewModel = singleProductViewModelFromJson(jsonString);

import 'dart:convert';

SingleProductViewModel singleProductViewModelFromJson(String str) =>
    SingleProductViewModel.fromJson(json.decode(str));

String singleProductViewModelToJson(SingleProductViewModel data) =>
    json.encode(data.toJson());

class SingleProductViewModel {
  SingleProductViewModel({
    this.status,
    this.message,
    this.data,
  });

  dynamic status;
  String? message;
  List<Datum>? data;

  factory SingleProductViewModel.fromJson(Map<String, dynamic> json) =>
      SingleProductViewModel(
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
    this.productId,
    this.type,
    this.vendorId,
    this.ratingTotal,
    this.title,
    this.sku,
    this.categoryId,
    this.categoryName,
    this.subCategoryId,
    this.subCategoryName,
    this.brandId,
    this.brandName,
    this.description,
    this.salePrice,
    this.salePriceCurrency,
    this.shippingCost,
    this.shippingCostCurrency,
    this.currentStock,
    this.unit,
    this.tag,
    this.discount,
    this.discountType,
    this.color,
    this.productColors,
    this.deliveryType,
    this.productDeliveryType,
    this.size,
    this.dateTime,
    this.imgUrl,
    this.wishlist,
  });

  String? productId;
  String? type;
  String? vendorId;
  String? ratingTotal;
  String? title;
  String? sku;
  String? categoryId;
  String? categoryName;
  String? subCategoryId;
  String? subCategoryName;
  String? brandId;
  String? brandName;
  String? description;
  String? salePrice;
  String? salePriceCurrency;
  String? shippingCost;
  String? shippingCostCurrency;
  String? currentStock;
  String? unit;
  String? tag;
  String? discount;
  String? discountType;
  String ?color;
  List<ProductColor> ?productColors;
  String? deliveryType;
  List<ProductDeliveryType>? productDeliveryType;
  String ?size;
  DateTime ?dateTime;
  String? imgUrl;
  String? wishlist;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        productId: json["product_id"] == null ? null : json["product_id"],
        type: json["type"] == null ? null : json["type"],
        vendorId: json["vendor_id"] == null ? null : json["vendor_id"],
        ratingTotal: json["rating_total"] == null ? null : json["rating_total"],
        title: json["title"] == null ? null : json["title"],
        sku: json["sku"] == null ? null : json["sku"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        subCategoryId:
            json["sub_category_id"] == null ? null : json["sub_category_id"],
        subCategoryName: json["sub_category_name"] == null
            ? null
            : json["sub_category_name"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        brandName: json["brand_name"] == null ? null : json["brand_name"],
        description: json["description"] == null ? null : json["description"],
        salePrice: json["sale_price"] == null ? null : json["sale_price"],
        salePriceCurrency: json["sale_price_currency"] == null
            ? null
            : json["sale_price_currency"],
        shippingCost:
            json["shipping_cost"] == null ? null : json["shipping_cost"],
        shippingCostCurrency: json["shipping_cost_currency"] == null
            ? null
            : json["shipping_cost_currency"],
        currentStock:
            json["current_stock"] == null ? null : json["current_stock"],
        unit: json["unit"] == null ? null : json["unit"],
        tag: json["tag"] == null ? null : json["tag"],
        discount: json["discount"] == null ? null : json["discount"],
        discountType:
            json["discount_type"] == null ? null : json["discount_type"],
        color: json["color"] == null ? null : json["color"],
        productColors: json["product_colors"] == null
            ? null
            : List<ProductColor>.from(
                json["product_colors"].map((x) => ProductColor.fromJson(x))),
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
        productDeliveryType: json["product_delivery_type"] == null
            ? null
            : List<ProductDeliveryType>.from(json["product_delivery_type"]
                .map((x) => ProductDeliveryType.fromJson(x))),
        size: json["size"] == null ? null : json["size"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        imgUrl: json["img_url"] == null ? null : json["img_url"],
        wishlist: json["wishlist"] == null ? null : json["wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId == null ? null : productId,
        "type": type == null ? null : type,
        "vendor_id": vendorId == null ? null : vendorId,
        "rating_total": ratingTotal == null ? null : ratingTotal,
        "title": title == null ? null : title,
        "sku": sku == null ? null : sku,
        "category_id": categoryId == null ? null : categoryId,
        "category_name": categoryName == null ? null : categoryName,
        "sub_category_id": subCategoryId == null ? null : subCategoryId,
        "sub_category_name": subCategoryName == null ? null : subCategoryName,
        "brand_id": brandId == null ? null : brandId,
        "brand_name": brandName == null ? null : brandName,
        "description": description == null ? null : description,
        "sale_price": salePrice == null ? null : salePrice,
        "sale_price_currency":
            salePriceCurrency == null ? null : salePriceCurrency,
        "shipping_cost": shippingCost == null ? null : shippingCost,
        "shipping_cost_currency":
            shippingCostCurrency == null ? null : shippingCostCurrency,
        "current_stock": currentStock == null ? null : currentStock,
        "unit": unit == null ? null : unit,
        "tag": tag == null ? null : tag,
        "discount": discount == null ? null : discount,
        "discount_type": discountType == null ? null : discountType,
        "color": color == null ? null : color,
        "product_colors": productColors == null
            ? null
            : List<dynamic>.from(productColors!.map((x) => x.toJson())),
        "delivery_type": deliveryType == null ? null : deliveryType,
        "product_delivery_type": productDeliveryType == null
            ? null
            : List<dynamic>.from(productDeliveryType!.map((x) => x.toJson())),
        "size": size == null ? null : size,
        "date_time": dateTime == null ? null : dateTime!.toIso8601String(),
        "img_url": imgUrl == null ? null : imgUrl,
        "wishlist": wishlist == null ? null : wishlist,
      };
}

class ProductColor {
  ProductColor({
    this.color,
  });

  String? color;

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
        color: json["color"] == null ? null : json["color"],
      );

  Map<String, dynamic> toJson() => {
        "color": color == null ? null : color,
      };
}

class ProductDeliveryType {
  ProductDeliveryType({
    this.deliveryType,
  });

  String? deliveryType;

  factory ProductDeliveryType.fromJson(Map<String, dynamic> json) =>
      ProductDeliveryType(
        deliveryType:
            json["delivery_type"] == null ? null : json["delivery_type"],
      );

  Map<String, dynamic> toJson() => {
        "delivery_type": deliveryType == null ? null : deliveryType,
      };
}
