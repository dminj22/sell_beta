import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Auth/login_page.dart';
import 'package:sell_beta_customer/Screen/Auth/otp_verify.dart';
import 'package:sell_beta_customer/Screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> userId;

  @override
  void initState() {
    super.initState();
    userId = _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('userId') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return FutureBuilder(
        future:userId,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            default:
              if (snapshot.data == "") {
                return LoginPage();
              } else if (snapshot.data != "") {
                user.userId = snapshot.data;
                return Home();
              } else {
                return LoginPage();
              }
          }
        });
  }
}
