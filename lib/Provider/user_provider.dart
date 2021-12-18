import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  var userId;
  var otp;
  void onChange(value){
    userId = value;
    otp = value;
    notifyListeners();
  }
}

class UserProfileModel extends ChangeNotifier{
  var name;
  var emailId;
  var number;
  var address;
  var totalPurchase;
  var country;
  var state;
  var city;
  var zip;
  var image;
  void onChange(value){
    name = value;
    emailId = value;
    number = value;
    address = value;
    totalPurchase = value;
    country = value;
    state = value;
    city = value;
    zip = value;
    image = value;
    notifyListeners();
  }
}