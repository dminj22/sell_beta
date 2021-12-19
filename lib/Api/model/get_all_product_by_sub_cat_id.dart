/// status : true
/// message : ""
/// data : [{"product_id":"11","type":null,"sku":"Product100000","vendor_id":null,"rating_num":"0","rating_total":"0.00","rating_user":"[]","title":"tftyt","category":"4","sub_category":"127","brand":"263","description":"<p><br></p>","num_of_imgs":null,"sale_price":"1.00","sale_price_currency":"9","purchase_price":"0.00","purchase_price_currency":"$","shipping_cost":"1.00","shipping_cost_currency":"9","current_stock":null,"unit":"4","tag":"test","discount":"12","discount_type":"percent","color":"3","delivery_type":"2","size":"l","date_time":"2021-12-18 13:45:22","img_url":"https://bodyrecomp.app/app/project/ecom/uploads/product_image_thumb/product_thumb6818.png","sales_currency":"₦","purchase_currency":null,"shipping_currency":"₦","wishlist":"true"},{"product_id":"10","type":null,"sku":"Product99999","vendor_id":null,"rating_num":"0","rating_total":"0.00","rating_user":"[]","title":"top","category":"4","sub_category":"127","brand":"264","description":"<p>gfd</p>","num_of_imgs":null,"sale_price":"0.02","sale_price_currency":"9","purchase_price":"0.00","purchase_price_currency":"$","shipping_cost":"0.03","shipping_cost_currency":"9","current_stock":null,"unit":"12","tag":"test","discount":"11","discount_type":"percent","color":"3","delivery_type":"2","size":"l","date_time":"2021-12-18 14:49:08","img_url":"https://bodyrecomp.app/app/project/ecom/uploads/product_image/default.jpg","sales_currency":"₦","purchase_currency":null,"shipping_currency":"₦","wishlist":"true"},{"product_id":"9","type":"vendor","sku":"Product-99999","vendor_id":"4","rating_num":"0","rating_total":"0.00","rating_user":"[]","title":"f","category":"4","sub_category":"127","brand":"264","description":"<p>vggv</p>","num_of_imgs":null,"sale_price":"6.00","sale_price_currency":"9","purchase_price":"0.00","purchase_price_currency":"$","shipping_cost":"0.01","shipping_cost_currency":"9","current_stock":null,"unit":"5","tag":"test","discount":"0.01","discount_type":"percent","color":"3","delivery_type":"10","size":"l","date_time":"2021-12-18 11:32:11","img_url":"https://bodyrecomp.app/app/project/ecom/uploads/product_image/default.jpg","sales_currency":"₦","purchase_currency":null,"shipping_currency":"₦","wishlist":"true"},{"product_id":"8","type":"vendor","sku":"Product-99999","vendor_id":"4","rating_num":"0","rating_total":"0.00","rating_user":"[]","title":"yf","category":"4","sub_category":"127","brand":"264","description":"                        <p>bhbh</p>","num_of_imgs":"0","sale_price":"56.00","sale_price_currency":"9","purchase_price":"0.00","purchase_price_currency":null,"shipping_cost":"0.08","shipping_cost_currency":"9","current_stock":null,"unit":"23","tag":"test","discount":"7","discount_type":"percent","color":"3","delivery_type":"2","size":"L ,XL","date_time":"2021-12-18 15:09:22","img_url":"https://bodyrecomp.app/app/project/ecom/uploads/product_image/default.jpg","sales_currency":"₦","purchase_currency":null,"shipping_currency":"₦","wishlist":"true"},{"product_id":"7","type":null,"sku":"Product100000","vendor_id":null,"rating_num":"0","rating_total":"0.00","rating_user":"[]","title":"saree","category":"4","sub_category":"127","brand":"264","description":"<p>vvdfd</p>","num_of_imgs":null,"sale_price":"0.08","sale_price_currency":"9","purchase_price":"0.00","purchase_price_currency":"$","shipping_cost":"0.08","shipping_cost_currency":"9","current_stock":null,"unit":"10","tag":"test","discount":"13","discount_type":"percent","color":"1,3,4,5","delivery_type":"1,2,10","size":"L ,XL,XXL,XXXL","date_time":"2021-12-18 10:12:20","img_url":"https://bodyrecomp.app/app/project/ecom/uploads/product_image_thumb/product_thumb2761.png","sales_currency":"₦","purchase_currency":null,"shipping_currency":"₦","wishlist":"true"},{"product_id":"4","type":"vendor","sku":"Product-100000","vendor_id":"4","rating_num":"0","rating_total":"0.00","rating_user":"[]","title":"Kurta plazo","category":"4","sub_category":"127","brand":"279","description":"                        <p>kurta plazo </p>","num_of_imgs":"0","sale_price":"10.00","sale_price_currency":"9","purchase_price":"0.00","purchase_price_currency":null,"shipping_cost":"12.00","shipping_cost_currency":"9","current_stock":"10","unit":"10","tag":"product,ghj","discount":"10","discount_type":"nigeria","color":"1,3,4,5,6,9","delivery_type":"2,10","size":"L,M,S,XL,XLL","date_time":"2021-12-18 05:03:54","img_url":"https://bodyrecomp.app/app/project/ecom/uploads/product_image_thumb/product_thumb8828.png","sales_currency":"₦","purchase_currency":null,"shipping_currency":"₦","wishlist":"true"}]

class GetAllProductBySubCatId {
  GetAllProductBySubCatId({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetAllProductBySubCatId.fromJson(dynamic json) {
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

/// product_id : "11"
/// type : null
/// sku : "Product100000"
/// vendor_id : null
/// rating_num : "0"
/// rating_total : "0.00"
/// rating_user : "[]"
/// title : "tftyt"
/// category : "4"
/// sub_category : "127"
/// brand : "263"
/// description : "<p><br></p>"
/// num_of_imgs : null
/// sale_price : "1.00"
/// sale_price_currency : "9"
/// purchase_price : "0.00"
/// purchase_price_currency : "$"
/// shipping_cost : "1.00"
/// shipping_cost_currency : "9"
/// current_stock : null
/// unit : "4"
/// tag : "test"
/// discount : "12"
/// discount_type : "percent"
/// color : "3"
/// delivery_type : "2"
/// size : "l"
/// date_time : "2021-12-18 13:45:22"
/// img_url : "https://bodyrecomp.app/app/project/ecom/uploads/product_image_thumb/product_thumb6818.png"
/// sales_currency : "₦"
/// purchase_currency : null
/// shipping_currency : "₦"
/// wishlist : "true"

class Data {
  Data({
      String? productId, 
      dynamic type, 
      String? sku, 
      dynamic vendorId, 
      String? ratingNum, 
      String? ratingTotal, 
      String? ratingUser, 
      String? title, 
      String? category, 
      String? subCategory, 
      String? brand, 
      String? description, 
      dynamic numOfImgs, 
      String? salePrice, 
      String? salePriceCurrency, 
      String? purchasePrice, 
      String? purchasePriceCurrency, 
      String? shippingCost, 
      String? shippingCostCurrency, 
      dynamic currentStock, 
      String? unit, 
      String? tag, 
      String? discount, 
      String? discountType, 
      String? color, 
      String? deliveryType, 
      String? size, 
      String? dateTime, 
      String? imgUrl, 
      String? salesCurrency, 
      dynamic purchaseCurrency, 
      String? shippingCurrency, 
      String? wishlist,}){
    _productId = productId;
    _type = type;
    _sku = sku;
    _vendorId = vendorId;
    _ratingNum = ratingNum;
    _ratingTotal = ratingTotal;
    _ratingUser = ratingUser;
    _title = title;
    _category = category;
    _subCategory = subCategory;
    _brand = brand;
    _description = description;
    _numOfImgs = numOfImgs;
    _salePrice = salePrice;
    _salePriceCurrency = salePriceCurrency;
    _purchasePrice = purchasePrice;
    _purchasePriceCurrency = purchasePriceCurrency;
    _shippingCost = shippingCost;
    _shippingCostCurrency = shippingCostCurrency;
    _currentStock = currentStock;
    _unit = unit;
    _tag = tag;
    _discount = discount;
    _discountType = discountType;
    _color = color;
    _deliveryType = deliveryType;
    _size = size;
    _dateTime = dateTime;
    _imgUrl = imgUrl;
    _salesCurrency = salesCurrency;
    _purchaseCurrency = purchaseCurrency;
    _shippingCurrency = shippingCurrency;
    _wishlist = wishlist;
}

  Data.fromJson(dynamic json) {
    _productId = json['product_id'];
    _type = json['type'];
    _sku = json['sku'];
    _vendorId = json['vendor_id'];
    _ratingNum = json['rating_num'];
    _ratingTotal = json['rating_total'];
    _ratingUser = json['rating_user'];
    _title = json['title'];
    _category = json['category'];
    _subCategory = json['sub_category'];
    _brand = json['brand'];
    _description = json['description'];
    _numOfImgs = json['num_of_imgs'];
    _salePrice = json['sale_price'];
    _salePriceCurrency = json['sale_price_currency'];
    _purchasePrice = json['purchase_price'];
    _purchasePriceCurrency = json['purchase_price_currency'];
    _shippingCost = json['shipping_cost'];
    _shippingCostCurrency = json['shipping_cost_currency'];
    _currentStock = json['current_stock'];
    _unit = json['unit'];
    _tag = json['tag'];
    _discount = json['discount'];
    _discountType = json['discount_type'];
    _color = json['color'];
    _deliveryType = json['delivery_type'];
    _size = json['size'];
    _dateTime = json['date_time'];
    _imgUrl = json['img_url'];
    _salesCurrency = json['sales_currency'];
    _purchaseCurrency = json['purchase_currency'];
    _shippingCurrency = json['shipping_currency'];
    _wishlist = json['wishlist'];
  }
  String? _productId;
  dynamic _type;
  String? _sku;
  dynamic _vendorId;
  String? _ratingNum;
  String? _ratingTotal;
  String? _ratingUser;
  String? _title;
  String? _category;
  String? _subCategory;
  String? _brand;
  String? _description;
  dynamic _numOfImgs;
  String? _salePrice;
  String? _salePriceCurrency;
  String? _purchasePrice;
  String? _purchasePriceCurrency;
  String? _shippingCost;
  String? _shippingCostCurrency;
  dynamic _currentStock;
  String? _unit;
  String? _tag;
  String? _discount;
  String? _discountType;
  String? _color;
  String? _deliveryType;
  String? _size;
  String? _dateTime;
  String? _imgUrl;
  String? _salesCurrency;
  dynamic _purchaseCurrency;
  String? _shippingCurrency;
  String? _wishlist;

  String? get productId => _productId;
  dynamic get type => _type;
  String? get sku => _sku;
  dynamic get vendorId => _vendorId;
  String? get ratingNum => _ratingNum;
  String? get ratingTotal => _ratingTotal;
  String? get ratingUser => _ratingUser;
  String? get title => _title;
  String? get category => _category;
  String? get subCategory => _subCategory;
  String? get brand => _brand;
  String? get description => _description;
  dynamic get numOfImgs => _numOfImgs;
  String? get salePrice => _salePrice;
  String? get salePriceCurrency => _salePriceCurrency;
  String? get purchasePrice => _purchasePrice;
  String? get purchasePriceCurrency => _purchasePriceCurrency;
  String? get shippingCost => _shippingCost;
  String? get shippingCostCurrency => _shippingCostCurrency;
  dynamic get currentStock => _currentStock;
  String? get unit => _unit;
  String? get tag => _tag;
  String? get discount => _discount;
  String? get discountType => _discountType;
  String? get color => _color;
  String? get deliveryType => _deliveryType;
  String? get size => _size;
  String? get dateTime => _dateTime;
  String? get imgUrl => _imgUrl;
  String? get salesCurrency => _salesCurrency;
  dynamic get purchaseCurrency => _purchaseCurrency;
  String? get shippingCurrency => _shippingCurrency;
  String? get wishlist => _wishlist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['type'] = _type;
    map['sku'] = _sku;
    map['vendor_id'] = _vendorId;
    map['rating_num'] = _ratingNum;
    map['rating_total'] = _ratingTotal;
    map['rating_user'] = _ratingUser;
    map['title'] = _title;
    map['category'] = _category;
    map['sub_category'] = _subCategory;
    map['brand'] = _brand;
    map['description'] = _description;
    map['num_of_imgs'] = _numOfImgs;
    map['sale_price'] = _salePrice;
    map['sale_price_currency'] = _salePriceCurrency;
    map['purchase_price'] = _purchasePrice;
    map['purchase_price_currency'] = _purchasePriceCurrency;
    map['shipping_cost'] = _shippingCost;
    map['shipping_cost_currency'] = _shippingCostCurrency;
    map['current_stock'] = _currentStock;
    map['unit'] = _unit;
    map['tag'] = _tag;
    map['discount'] = _discount;
    map['discount_type'] = _discountType;
    map['color'] = _color;
    map['delivery_type'] = _deliveryType;
    map['size'] = _size;
    map['date_time'] = _dateTime;
    map['img_url'] = _imgUrl;
    map['sales_currency'] = _salesCurrency;
    map['purchase_currency'] = _purchaseCurrency;
    map['shipping_currency'] = _shippingCurrency;
    map['wishlist'] = _wishlist;
    return map;
  }

}