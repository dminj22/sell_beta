/// status : true
/// message : "order list get successfully"
/// data : [{"order_id":"4","order_code":"82120830","vendor_id":"4","user_id":"1","product_id":"2","address_id":"1","quantity":"2","amount":"20.00","total_amount":"40.00","tax_charge":"0.00","shipping_charge":"0.00","coupon":"","no_of_product":"2","delivery_status":"Picked Up","payment_status":"paid","payment_method":"COD","refund":"No Refund","order_date":"2021-10-16","status":"1","date_time":"2021-10-14 11:41:58","username":"Manish","profile_photo_url":""},{"order_id":"2","order_code":"82120830","vendor_id":"4","user_id":"1","product_id":"2","address_id":"1","quantity":"2","amount":"20.00","total_amount":"40.00","tax_charge":"0.00","shipping_charge":"0.00","coupon":"","no_of_product":"2","delivery_status":"Delivered","payment_status":"paid","payment_method":"COD","refund":"No Refund","order_date":"2021-10-16","status":"1","date_time":"2021-10-14 11:41:58","username":"Manish","profile_photo_url":""}]

class CustomerOrderListModel {
  CustomerOrderListModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CustomerOrderListModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;

  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// order_id : "4"
/// order_code : "82120830"
/// vendor_id : "4"
/// user_id : "1"
/// product_id : "2"
/// address_id : "1"
/// quantity : "2"
/// amount : "20.00"
/// total_amount : "40.00"
/// tax_charge : "0.00"
/// shipping_charge : "0.00"
/// coupon : ""
/// no_of_product : "2"
/// delivery_status : "Picked Up"
/// payment_status : "paid"
/// payment_method : "COD"
/// refund : "No Refund"
/// order_date : "2021-10-16"
/// status : "1"
/// date_time : "2021-10-14 11:41:58"
/// username : "Manish"
/// profile_photo_url : ""

class Data {
  Data({
      String? orderId, 
      String? orderCode, 
      String? vendorId, 
      String? userId, 
      String? productId, 
      String? addressId, 
      String? quantity, 
      String? amount, 
      String? totalAmount, 
      String? taxCharge, 
      String? shippingCharge, 
      String? coupon, 
      String? noOfProduct, 
      String? deliveryStatus, 
      String? paymentStatus, 
      String? paymentMethod, 
      String? refund, 
      String? orderDate, 
      String? status, 
      String? dateTime, 
      String? username, 
      String? profilePhotoUrl,}){
    _orderId = orderId;
    _orderCode = orderCode;
    _vendorId = vendorId;
    _userId = userId;
    _productId = productId;
    _addressId = addressId;
    _quantity = quantity;
    _amount = amount;
    _totalAmount = totalAmount;
    _taxCharge = taxCharge;
    _shippingCharge = shippingCharge;
    _coupon = coupon;
    _noOfProduct = noOfProduct;
    _deliveryStatus = deliveryStatus;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _refund = refund;
    _orderDate = orderDate;
    _status = status;
    _dateTime = dateTime;
    _username = username;
    _profilePhotoUrl = profilePhotoUrl;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _orderCode = json['order_code'];
    _vendorId = json['vendor_id'];
    _userId = json['user_id'];
    _productId = json['product_id'];
    _addressId = json['address_id'];
    _quantity = json['quantity'];
    _amount = json['amount'];
    _totalAmount = json['total_amount'];
    _taxCharge = json['tax_charge'];
    _shippingCharge = json['shipping_charge'];
    _coupon = json['coupon'];
    _noOfProduct = json['no_of_product'];
    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _paymentMethod = json['payment_method'];
    _refund = json['refund'];
    _orderDate = json['order_date'];
    _status = json['status'];
    _dateTime = json['date_time'];
    _username = json['username'];
    _profilePhotoUrl = json['profile_photo_url'];
  }
  String? _orderId;
  String? _orderCode;
  String? _vendorId;
  String? _userId;
  String? _productId;
  String? _addressId;
  String? _quantity;
  String? _amount;
  String? _totalAmount;
  String? _taxCharge;
  String? _shippingCharge;
  String? _coupon;
  String? _noOfProduct;
  String? _deliveryStatus;
  String? _paymentStatus;
  String? _paymentMethod;
  String? _refund;
  String? _orderDate;
  String? _status;
  String? _dateTime;
  String? _username;
  String? _profilePhotoUrl;

  String? get orderId => _orderId;
  String? get orderCode => _orderCode;
  String? get vendorId => _vendorId;
  String? get userId => _userId;
  String? get productId => _productId;
  String? get addressId => _addressId;
  String? get quantity => _quantity;
  String? get amount => _amount;
  String? get totalAmount => _totalAmount;
  String? get taxCharge => _taxCharge;
  String? get shippingCharge => _shippingCharge;
  String? get coupon => _coupon;
  String? get noOfProduct => _noOfProduct;
  String? get deliveryStatus => _deliveryStatus;
  String? get paymentStatus => _paymentStatus;
  String? get paymentMethod => _paymentMethod;
  String? get refund => _refund;
  String? get orderDate => _orderDate;
  String? get status => _status;
  String? get dateTime => _dateTime;
  String? get username => _username;
  String? get profilePhotoUrl => _profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['order_code'] = _orderCode;
    map['vendor_id'] = _vendorId;
    map['user_id'] = _userId;
    map['product_id'] = _productId;
    map['address_id'] = _addressId;
    map['quantity'] = _quantity;
    map['amount'] = _amount;
    map['total_amount'] = _totalAmount;
    map['tax_charge'] = _taxCharge;
    map['shipping_charge'] = _shippingCharge;
    map['coupon'] = _coupon;
    map['no_of_product'] = _noOfProduct;
    map['delivery_status'] = _deliveryStatus;
    map['payment_status'] = _paymentStatus;
    map['payment_method'] = _paymentMethod;
    map['refund'] = _refund;
    map['order_date'] = _orderDate;
    map['status'] = _status;
    map['date_time'] = _dateTime;
    map['username'] = _username;
    map['profile_photo_url'] = _profilePhotoUrl;
    return map;
  }

}