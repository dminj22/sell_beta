/// status : true

class CartUpdateQuantityModel {
  CartUpdateQuantityModel({
      bool? status,}){
    _status = status;
}

  CartUpdateQuantityModel.fromJson(dynamic json) {
    _status = json['status'];
  }
  bool? _status;

  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    return map;
  }

}