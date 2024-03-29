import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sell_beta_customer/Api/base_url.dart';
import 'package:sell_beta_customer/Api/model/add_address_model.dart';
import 'package:sell_beta_customer/Api/model/add_to_cart_model.dart';
import 'package:sell_beta_customer/Api/model/cart_update_quantity_model.dart';
import 'package:sell_beta_customer/Api/model/create_order_model.dart';
import 'package:sell_beta_customer/Api/model/customer_order_list_model.dart';
import 'package:sell_beta_customer/Api/model/delete_cart_model.dart';
import 'package:sell_beta_customer/Api/model/follow_vendor_model.dart';
import 'package:sell_beta_customer/Api/model/forget_otp_verify_model.dart';
import 'package:sell_beta_customer/Api/model/forget_password_model.dart';
import 'package:sell_beta_customer/Api/model/forget_update_password_model.dart';
import 'package:sell_beta_customer/Api/model/get_address_list_model.dart';
import 'package:sell_beta_customer/Api/model/get_all_notification_model.dart';
import 'package:sell_beta_customer/Api/model/get_all_product_by_sub_cat_id.dart';
import 'package:sell_beta_customer/Api/model/get_cart_list_model.dart';
import 'package:sell_beta_customer/Api/model/get_cat_sub_cat_model.dart';
import 'package:sell_beta_customer/Api/model/get_category_model.dart';
import 'package:sell_beta_customer/Api/model/get_city_list_model.dart';
import 'package:sell_beta_customer/Api/model/get_feeds_model.dart';
import 'package:sell_beta_customer/Api/model/get_follower_model.dart';
import 'package:sell_beta_customer/Api/model/get_product_by_sub_id_model.dart';
import 'package:sell_beta_customer/Api/model/get_sub_category_model.dart';
import 'package:sell_beta_customer/Api/model/login_model.dart';
import 'package:sell_beta_customer/Api/model/otp_verify_model.dart';
import 'package:sell_beta_customer/Api/model/payment_initiate_model.dart';
import 'package:sell_beta_customer/Api/model/product_review_model.dart';
import 'package:sell_beta_customer/Api/model/shop_product_model.dart';
import 'package:sell_beta_customer/Api/model/single_product_images_model.dart';
import 'package:sell_beta_customer/Api/model/single_product_view_model.dart';
import 'package:sell_beta_customer/Api/model/state_list_model.dart';
import 'package:sell_beta_customer/Api/model/universal_model.dart';
import 'package:sell_beta_customer/Api/model/update_profile_model.dart';
import 'package:sell_beta_customer/Api/model/user_details_model.dart';
import 'package:sell_beta_customer/Api/model/vendor_details_model.dart';
import 'package:sell_beta_customer/Api/model/verification_payment_model.dart';
import 'package:sell_beta_customer/Screen/Product/create_order/create_order.dart';

Url _url = Url();

//User Sign Up
Future<UniversalModel?> signUp(username, email, password) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.signUp));
  request.fields.addAll(
      {'username': '$username', 'email': '$email', 'password': '$password'});
  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

    return userDetailsModelFromJson(str);
  } else {
    return null;
  }
}

//Forgot Password
Future<ForgetPasswordModel?> forgetPassword(email) async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.forgetPassword));

  request.fields.addAll({'email': "$email"});



  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

    return updateProfileModelFromJson(str);
  } else {
    return null;
  }
}

// get categories
Future<GetCategoryModel?> getCategories() async {
  var request = http.MultipartRequest('POST', Uri.parse(_url.getAllCategory));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

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

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();

      return SingleProductViewModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  } catch (e) {
  }
}

// get single product Image
Future<SingleViewProductImageModel?> getSingleProductImage(id) async {
  try {
    var request = http.MultipartRequest(
        'POST', Uri.parse(_url.singleProductViewAllImages));
    request.fields.addAll({'product_id': id});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();

      return singleViewProductImageModelFromJson(str);
    } else {
      return null;
    }
  } catch (e) {
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

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

    return addToCartModelFromJson(str);
  } else {
  }
}

// get vendor details
Future<VendorDetailsModel?> getVendorDetails(vendorId, userId) async {
  var request =
      http.MultipartRequest('POST', Uri.parse(_url.vendorShopDetails));
  request.fields.addAll({'vendor_id': '$vendorId', "user_id": "$userId"});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();

    return vendorDetailsModelFromJson(str);
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
  try {
    var request =
        http.MultipartRequest('POST', Uri.parse(_url.multipleDeleteCartList));
    request.fields.addAll(cartId);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final str = await response.stream.bytesToString();
      return DeleteCartModel.fromJson(json.decode(str));
    } else {
      return null;
    }
  } catch (e) {
  }
}

Future<GetFollowerModel?> getFollowerList(id) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://bodyrecomp.app/app/project/ecom/api/getvendorFollowerList'));
  request.fields.addAll({'vendor_id': '$id'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return GetFollowerModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCatSubCatModel?> getCatSubCat(id) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://bodyrecomp.app/app/project/ecom/api/vendor_categories_subcategories_brand'));
  request.fields.addAll({'vendor_id': '$id'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return GetCatSubCatModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CustomerOrderListModel?> customerOrderList(userId) async {
try{  var request = http.MultipartRequest(
    'POST',
    Uri.parse(
        'https://bodyrecomp.app/app/project/ecom/api/customerorder_list'));
request.fields.addAll({'user_id': '$userId'});

http.StreamedResponse response = await request.send();
if (response.statusCode == 200) {
  final str = await response.stream.bytesToString();
  return CustomerOrderListModel.fromJson(json.decode(str));
} else {
  return null;
}}catch(e){
  print(e);
}
}

Future<CustomerOrderListModel?> singleOrderDetails(orderId) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://bodyrecomp.app/app/project/ecom/api/singleorderview'));
  request.fields.addAll({'order_id': '$orderId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CustomerOrderListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CartUpdateQuantityModel?> updateCartQuantity(
    cartId, quantity, price) async {
  var headers = {
    'Cookie': 'ci_session=bd4ed895b2380157766dde4c5cf12014f3de47c7'
  };
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://bodyrecomp.app/app/project/ecom/api/updatecartqunatity'));
  request.fields.addAll(
      {'cart_id': '$cartId', 'quantity': '$quantity', 'price': '$price'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CartUpdateQuantityModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<CreateOrderModel?> createOrder(details) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://bodyrecomp.app/app/project/ecom/api/create_order'));
  request.fields.addAll(details);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return CreateOrderModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetAddressListModel?> getAddressList(userId) async {
  var headers = {
    'Cookie': 'ci_session=f4a1535d17e12396c512061cd095046c963c1ee3'
  };
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://bodyrecomp.app/app/project/ecom/api/getUserShippingAddressList'));
  request.fields.addAll({'user_id': '$userId'});

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return GetAddressListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<StateListModel?> getStateList() async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://bodyrecomp.app/app/project/ecom/api/getAllState'));
  request.fields.addAll({'country_id': '1'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return StateListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<GetCityListModel?> getCityList(stateId) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://bodyrecomp.app/app/project/ecom/api/getAllCity'));
  request.fields.addAll({'state_id': '$stateId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return GetCityListModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<AddAddressModel?> addAddress(
    userId, name, email, number, address, stateId, cityId, area, zip) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://bodyrecomp.app/app/project/ecom/api/insert_user_address'));
  request.fields.addAll({
    'user_id': '$userId',
    'full_name': '$name',
    'email': '$email',
    'mobile_no': '$number',
    'address': '$address',
    'country_id': '1',
    'state_id': '$stateId',
    'city_id': '$cityId',
    'area': '$area',
    'zip': '$zip'
  });

  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return AddAddressModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}

Future<FollowVendorModel?> followVendor(userId, vendorId, type) async {
  var request = http.MultipartRequest('POST',
      Uri.parse('https://bodyrecomp.app/app/project/ecom/api/follow_unfollow'));
  request.fields.addAll(
      {'user_id': '$userId', 'vendor_id': '$vendorId', 'type': '$type'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return FollowVendorModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}



Future<PaymentInitiateModel?> paymentInitiate(email, amount, userId) async {
  var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://bodyrecomp.app/app/project/ecom/api/payment_intrigration'));
  request.fields
      .addAll({'email': '$email', 'amount': '$amount', 'user_id': '$userId'});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return PaymentInitiateModel.fromJson(json.decode(str));
  } else {
    return null;
  }
}


Future<VerificationPaymentModel?> verifyPayment(referenceId)async{

  var request = http.Request('GET', Uri.parse('https://bodyrecomp.app/app/project/ecom/api/verify_payment/$referenceId'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return VerificationPaymentModel.fromJson(json.decode(str));
  }
  else {
    return null;
  }

}



Future<GetFeedsModel?> getFeeds()async{

  var request = http.Request('POST', Uri.parse('https://bodyrecomp.app/app/project/ecom/api/feed_list'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final str = await response.stream.bytesToString();
    return GetFeedsModel.fromJson(json.decode(str));
  }
  else {
    return null;
  }

}