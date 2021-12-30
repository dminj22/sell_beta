/// status : true
/// data : [{"category_list":[{"category_name":"Fashion","category_id":"4"},{"category_name":"Phones & Tablets","category_id":"5"}],"sub_category_list":[{"sub_category_name":"Women's Fashion","sub_category_id":"127"},{"sub_category_name":"men fassion","sub_category_id":"129"}],"brand_list":[{"brand_name":"Sandisk","brand_id":"264"},{"brand_name":"reebok","brand_id":"285"},{"brand_name":"Innoson","brand_id":"279"}]}]

class GetCatSubCatModel {
  GetCatSubCatModel({
      bool? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  GetCatSubCatModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;

  bool? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// category_list : [{"category_name":"Fashion","category_id":"4"},{"category_name":"Phones & Tablets","category_id":"5"}]
/// sub_category_list : [{"sub_category_name":"Women's Fashion","sub_category_id":"127"},{"sub_category_name":"men fassion","sub_category_id":"129"}]
/// brand_list : [{"brand_name":"Sandisk","brand_id":"264"},{"brand_name":"reebok","brand_id":"285"},{"brand_name":"Innoson","brand_id":"279"}]

class Data {
  Data({
      List<Category_list>? categoryList, 
      List<Sub_category_list>? subCategoryList, 
      List<Brand_list>? brandList,}){
    _categoryList = categoryList;
    _subCategoryList = subCategoryList;
    _brandList = brandList;
}

  Data.fromJson(dynamic json) {
    if (json['category_list'] != null) {
      _categoryList = [];
      json['category_list'].forEach((v) {
        _categoryList?.add(Category_list.fromJson(v));
      });
    }
    if (json['sub_category_list'] != null) {
      _subCategoryList = [];
      json['sub_category_list'].forEach((v) {
        _subCategoryList?.add(Sub_category_list.fromJson(v));
      });
    }
    if (json['brand_list'] != null) {
      _brandList = [];
      json['brand_list'].forEach((v) {
        _brandList?.add(Brand_list.fromJson(v));
      });
    }
  }
  List<Category_list>? _categoryList;
  List<Sub_category_list>? _subCategoryList;
  List<Brand_list>? _brandList;

  List<Category_list>? get categoryList => _categoryList;
  List<Sub_category_list>? get subCategoryList => _subCategoryList;
  List<Brand_list>? get brandList => _brandList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_categoryList != null) {
      map['category_list'] = _categoryList?.map((v) => v.toJson()).toList();
    }
    if (_subCategoryList != null) {
      map['sub_category_list'] = _subCategoryList?.map((v) => v.toJson()).toList();
    }
    if (_brandList != null) {
      map['brand_list'] = _brandList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// brand_name : "Sandisk"
/// brand_id : "264"

class Brand_list {
  Brand_list({
      String? brandName, 
      String? brandId,}){
    _brandName = brandName;
    _brandId = brandId;
}

  Brand_list.fromJson(dynamic json) {
    _brandName = json['brand_name'];
    _brandId = json['brand_id'];
  }
  String? _brandName;
  String? _brandId;

  String? get brandName => _brandName;
  String? get brandId => _brandId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand_name'] = _brandName;
    map['brand_id'] = _brandId;
    return map;
  }

}

/// sub_category_name : "Women's Fashion"
/// sub_category_id : "127"

class Sub_category_list {
  Sub_category_list({
      String? subCategoryName, 
      String? subCategoryId,}){
    _subCategoryName = subCategoryName;
    _subCategoryId = subCategoryId;
}

  Sub_category_list.fromJson(dynamic json) {
    _subCategoryName = json['sub_category_name'];
    _subCategoryId = json['sub_category_id'];
  }
  String? _subCategoryName;
  String? _subCategoryId;

  String? get subCategoryName => _subCategoryName;
  String? get subCategoryId => _subCategoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sub_category_name'] = _subCategoryName;
    map['sub_category_id'] = _subCategoryId;
    return map;
  }

}

/// category_name : "Fashion"
/// category_id : "4"

class Category_list {
  Category_list({
      String? categoryName, 
      String? categoryId,}){
    _categoryName = categoryName;
    _categoryId = categoryId;
}

  Category_list.fromJson(dynamic json) {
    _categoryName = json['category_name'];
    _categoryId = json['category_id'];
  }
  String? _categoryName;
  String? _categoryId;

  String? get categoryName => _categoryName;
  String? get categoryId => _categoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_name'] = _categoryName;
    map['category_id'] = _categoryId;
    return map;
  }

}