import 'dart:convert';
/// status : true
/// message : "vendor shop details."
/// data : [{"vendor_id":"4","name":"Omm","email":"yash@gmail.com","company":"Yash company","address":"mumbai","rating_total":"3.0","logo":"https://bodyrecomp.app/app/project/ecom/uploads/vendor_logo_image/logo_4.png","vendorFollowerCount":2,"follow":"false"}]

VendorDetailsModel vendorDetailsModelFromJson(String str) => VendorDetailsModel.fromJson(json.decode(str));
String vendorDetailsModelToJson(VendorDetailsModel data) => json.encode(data.toJson());
class VendorDetailsModel {
  VendorDetailsModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  VendorDetailsModel.fromJson(dynamic json) {
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

/// vendor_id : "4"
/// name : "Omm"
/// email : "yash@gmail.com"
/// company : "Yash company"
/// address : "mumbai"
/// rating_total : "3.0"
/// logo : "https://bodyrecomp.app/app/project/ecom/uploads/vendor_logo_image/logo_4.png"
/// vendorFollowerCount : 2
/// follow : "false"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? vendorId, 
      String? name, 
      String? email, 
      String? company, 
      String? address, 
      String? ratingTotal, 
      String? logo, 
      int? vendorFollowerCount, 
      String? follow,}){
    _vendorId = vendorId;
    _name = name;
    _email = email;
    _company = company;
    _address = address;
    _ratingTotal = ratingTotal;
    _logo = logo;
    _vendorFollowerCount = vendorFollowerCount;
    _follow = follow;
}

  Data.fromJson(dynamic json) {
    _vendorId = json['vendor_id'];
    _name = json['name'];
    _email = json['email'];
    _company = json['company'];
    _address = json['address'];
    _ratingTotal = json['rating_total'];
    _logo = json['logo'];
    _vendorFollowerCount = json['vendorFollowerCount'];
    _follow = json['follow'];
  }
  String? _vendorId;
  String? _name;
  String? _email;
  String? _company;
  String? _address;
  String? _ratingTotal;
  String? _logo;
  int? _vendorFollowerCount;
  String? _follow;

  String? get vendorId => _vendorId;
  String? get name => _name;
  String? get email => _email;
  String? get company => _company;
  String? get address => _address;
  String? get ratingTotal => _ratingTotal;
  String? get logo => _logo;
  int? get vendorFollowerCount => _vendorFollowerCount;
  String? get follow => _follow;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vendor_id'] = _vendorId;
    map['name'] = _name;
    map['email'] = _email;
    map['company'] = _company;
    map['address'] = _address;
    map['rating_total'] = _ratingTotal;
    map['logo'] = _logo;
    map['vendorFollowerCount'] = _vendorFollowerCount;
    map['follow'] = _follow;
    return map;
  }

}