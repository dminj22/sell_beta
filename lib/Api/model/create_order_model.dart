/// status : true
/// message : "Your Order submit successfully."
/// data : {"order_id":"23","order_code":"94064215","cart_id":"[\"107\"]","user_id":"44","address_id":"5","order_date":"2022-01-05","coupon":null,"delivery_status":"Pending","payment_status":"Unpaid","payment_method":"COD","refund":null,"date_time":"2022-01-05 16:31:26"}

class CreateOrderModel {
  CreateOrderModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CreateOrderModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;

  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// order_id : "23"
/// order_code : "94064215"
/// cart_id : "[\"107\"]"
/// user_id : "44"
/// address_id : "5"
/// order_date : "2022-01-05"
/// coupon : null
/// delivery_status : "Pending"
/// payment_status : "Unpaid"
/// payment_method : "COD"
/// refund : null
/// date_time : "2022-01-05 16:31:26"

class Data {
  Data({
      String? orderId, 
      String? orderCode, 
      String? cartId, 
      String? userId, 
      String? addressId, 
      String? orderDate, 
      dynamic coupon, 
      String? deliveryStatus, 
      String? paymentStatus, 
      String? paymentMethod, 
      dynamic refund, 
      String? dateTime,}){
    _orderId = orderId;
    _orderCode = orderCode;
    _cartId = cartId;
    _userId = userId;
    _addressId = addressId;
    _orderDate = orderDate;
    _coupon = coupon;
    _deliveryStatus = deliveryStatus;
    _paymentStatus = paymentStatus;
    _paymentMethod = paymentMethod;
    _refund = refund;
    _dateTime = dateTime;
}

  Data.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _orderCode = json['order_code'];
    _cartId = json['cart_id'];
    _userId = json['user_id'];
    _addressId = json['address_id'];
    _orderDate = json['order_date'];
    _coupon = json['coupon'];
    _deliveryStatus = json['delivery_status'];
    _paymentStatus = json['payment_status'];
    _paymentMethod = json['payment_method'];
    _refund = json['refund'];
    _dateTime = json['date_time'];
  }
  String? _orderId;
  String? _orderCode;
  String? _cartId;
  String? _userId;
  String? _addressId;
  String? _orderDate;
  dynamic _coupon;
  String? _deliveryStatus;
  String? _paymentStatus;
  String? _paymentMethod;
  dynamic _refund;
  String? _dateTime;

  String? get orderId => _orderId;
  String? get orderCode => _orderCode;
  String? get cartId => _cartId;
  String? get userId => _userId;
  String? get addressId => _addressId;
  String? get orderDate => _orderDate;
  dynamic get coupon => _coupon;
  String? get deliveryStatus => _deliveryStatus;
  String? get paymentStatus => _paymentStatus;
  String? get paymentMethod => _paymentMethod;
  dynamic get refund => _refund;
  String? get dateTime => _dateTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['order_code'] = _orderCode;
    map['cart_id'] = _cartId;
    map['user_id'] = _userId;
    map['address_id'] = _addressId;
    map['order_date'] = _orderDate;
    map['coupon'] = _coupon;
    map['delivery_status'] = _deliveryStatus;
    map['payment_status'] = _paymentStatus;
    map['payment_method'] = _paymentMethod;
    map['refund'] = _refund;
    map['date_time'] = _dateTime;
    return map;
  }

}