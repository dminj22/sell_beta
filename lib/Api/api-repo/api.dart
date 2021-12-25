import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sell_beta_customer/Api/base_url.dart';
import 'package:sell_beta_customer/Api/model/add_to_cart_model.dart';
import 'package:sell_beta_customer/Api/model/delete_cart_model.dart';
import 'package:sell_beta_customer/Api/model/forget_otp_verify_model.dart';
import 'package:sell_beta_customer/Api/model/forget_password_model.dart';
import 'package:sell_beta_customer/Api/model/forget_update_password_model.dart';
import 'package:sell_beta_customer/Api/model/get_all_notification_model.dart';
import 'package:sell_beta_customer/Api/model/get_all_product_by_sub_cat_id.dart';
import 'package:sell_beta_customer/Api/model/get_cart_list_model.dart';
import 'package:sell_beta_customer/Api/model/get_category_model.dart';
import 'package:sell_beta_customer/Api/model/get_product_by_sub_id_model.dart';
import 'package:sell_beta_customer/Api/model/get_sub_category_model.dart';
import 'package:sell_beta_customer/Api/model/login_model.dart';
import 'package:sell_beta_customer/Api/model/otp_verify_model.dart';
import 'package:sell_beta_customer/Api/model/product_review_model.dart';
import 'package:sell_beta_customer/Api/model/shop_product_model.dart';
import 'package:sell_beta_customer/Api/model/single_product_images_model.dart';
import 'package:sell_beta_customer/Api/model/single_product_view_model.dart';
import 'package:sell_beta_customer/Api/model/universal_model.dart';
import 'package:sell_beta_customer/Api/model/update_profile_model.dart';
import 'package:sell_beta_customer/Api/model/user_details_model.dart';
import 'package:sell_beta_customer/Api/model/vendor_details_model.dart';

Url _url = Url();
Logger _log = Logger();
//User Sign Up
Future<UniversalModel?> signUp(username, email, password) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.signUp));
  request.fields.addAll(
      {'username': '$username', 'email': '$email', 'password': '$password'});
  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return universalModelFromJson(str);
  } else {
    return null;
  }
}

//User Login
Future<LoginModel?> login(email, password) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.login));
  request.fields.addAll({'email': '$email', 'password': '$password'});

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return loginModelFromJson(str);
  } else {
    return null;
  }
}

//User Details
Future<UserDetailsModel?> userDetails(userId) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.getUserProfileDetails));
  request.fields.addAll({'user_id': '$userId'});

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return userDetailsModelFromJson(str);
  } else {
    return null;
  }
}

//Forgot Password
Future<ForgetPasswordModel?> forgetPassword(email) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.forgetPassword));

  request.fields.addAll({'email': "$email"});

  _log.d("$request || ${request.fields}");

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return forgetPasswordModelFromJson(str);
  } else {
    return null;
  }
}

//otp Verify
Future<OtpVerifyModel?> otpVerify(email, otp) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.verifyOTP));
  request.fields.addAll({'email': '$email', 'otp': '$otp'});

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return otpVerifyModelFromJson(str);
  } else {
    return null;
  }
}

// forgot otp verify
Future<ForgetOtpVerifyModel?> forgotOtpVerify(email, otp) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.verifyForgotPasswordOtp));
  request.fields.addAll({'email': '$email', 'otp': '$otp'});

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return forgetOtpVerifyModelFromJson(str);
  } else {
    return null;
  }
}

//forgot update password
Future<ForgetUpdatePasswordModel?> forgetUpdatePassword(email, password) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.forgetUpdatePassword));
  request.fields.addAll({'email': '$email', 'update_password': '$password'});
  _log.d("$request || ${request.fields}");
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return forgetUpdatePasswordModelFromJson(str);
  } else {
    return null;
  }
}

//update profile
Future<UpdateProfileModel?> updateProfile(
    userId, name, phone, address, country, state, city, zip) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.updateUserProfile));
  request.fields.addAll({
    'full_name': '$name',
    'phone': '$phone',
    'full_address': '$address',
    'country': '$country',
    'state': '$state',
    'city': '$city',
    'zip': '$zip',
    'user_id': '$userId'
  });

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return updateProfileModelFromJson(str);
  } else {
    return null;
  }
}

//upload Profile Pic
Future<UpdateProfileModel?> uploadProfilePic(
    userId, image, name, phone, address, country, state, city, zip) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.updateUserProfile));
  request.fields.addAll({
    'full_name': '$name',
    'phone': '$phone',
    'full_address': '$address',
    'country': '$country',
    'state': '$state',
    'city': '$city',
    'zip': '$zip',
    'user_id': '$userId'
  });
  request.files
      .add(await http.MultipartFile.fromPath('profile_photo', '$image'));

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return updateProfileModelFromJson(str);
  } else {
    return null;
  }
}

// get categories
Future<GetCategoryModel?> getCategories() async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.getAllCategory));

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return getCategoryModelFromJson(str);
  } else {
    return null;
  }
}

// get sub Categories
Future<GetSubCategoryModel?> getSubCategory(catId) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.getAllSubCategory));
  request.fields.addAll({'category_id': '$catId'});

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return getSubCategoryModelFromJson(str);
  } else {
    return null;
  }
}

// get notification
Future<GetAllNotificationModel?> getNotification() async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.getAllNotifications));

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return getAllNotificationModelFromJson(str);
  } else {
    return null;
  }
}

// get all product by sub Id
Future<GetProductBySubIdModel?> getAllProductBySubId(id) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.getAllProductBySubCategory));
  request.fields.addAll({
    'sub_category_id': '$id',
  });

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return getProductBySubIdModelFromJson(str);
  } else {
    return null;
  }
}

//get single product
Future<SingleProductViewModel?> getSingleProduct(id, userId) async {
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse(_url.singleProductDetails));
    request.fields.addAll({'product_id': id, "user_id": userId});

    http.StreamedResponse response = await request.send();
    _log.d("$request || ${request.fields}");
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      _log.d(str);
      return SingleProductViewModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  } catch (e) {
    print(e);
  }
}

// get single product Image
Future<SingleViewProductImageModel?> getSingleProductImage(id) async {
  try {
    var request = http.MultipartRequest(
        'POST', Uri.parse(_url.singleProductViewAllImages));
    request.fields.addAll({'product_id': id});

    http.StreamedResponse response = await request.send();
    _log.d("$request || ${request.fields}");
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      _log.d(str);
      return singleViewProductImageModelFromJson(str);
    } else {
      return null;
    }
  } catch (e) {
    print(e);
  }
}

// get shop product
Future<ShopProductModel?> getShopProduct(id) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.vendorProductsShop));
  request.fields.addAll({'vendor_id': '$id'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.d(str);
    return shopProductModelFromJson(str);
  } else {
    return null;
  }
}

// get cart list
Future<GetCartListModel?> getCartList(userId) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.getAddToCartList));
  request.fields.addAll({'user_id': '$userId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.d(str);
    return getCartListModelFromJson(str);
  } else {
    return null;
  }
}

// add to cart
Future<AddToCartModel?> addToCart(
    userId, vendorId, prodId, quantity, price, size, color) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.addToCart));
  request.fields.addAll({
    'user_id': '$userId',
    'product_id': '$prodId',
    'quantity': '$quantity',
    'price': '$price',
    'vendor_id': '$vendorId',
    'size': '$size',
    'color': '$color'
  });

  http.StreamedResponse response = await request.send();
  _log.d("$request || ${request.fields}");
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.e(str);
    return addToCartModelFromJson(str);
  } else {
    print(response.reasonPhrase);
  }
}

// get vendor details
Future<VendorDetailModel?> getVendorDetails(userId) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.vendorShopDetails));
  request.fields.addAll({'vendor_id': '$userId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    _log.d(str);
    return vendorDetailModelFromJson(str);
  } else {
    return null;
  }
}

// get related product
Future<GetAllProductBySubCatId?> getRelatedProduct(id) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.getAllProductBySubCategory));
  request.fields.addAll({'sub_category_id': '$id'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return GetAllProductBySubCatId.fromJson(json.decode(str));
  } else {
    return null;
  }
}

// product review
Future<ProductReviewModel?> productReview(id) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.getProductReviewsList));
  request.fields.addAll({'product_id': '$id'});
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return productReviewModelFromJson(str);
  } else {
    return null;
  }
}

// delete cart item
Future<DeleteCartModel?> deleteCartItem(cartId) async {
try{  var request =
http.MultipartRequest('POST', Uri.parse(_url.multipleDeleteCartList));
request.fields.addAll(cartId);

http.StreamedResponse response = await request.send();
print(request.fields);
if (response.statusCode == 200) {
  final str = await response.stream.bytesToString();
  print(str);
  return DeleteCartModel.fromJson(json.decode(str));
} else {
  return null;
}}catch(e){
  print(e);
}
}
