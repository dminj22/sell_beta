import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Categories/category.dart';
import 'package:sell_beta_customer/Screen/Product/Cart/cart_page.dart';
import 'package:sell_beta_customer/Screen/Product/product_by_sub_id.dart';
import 'package:sell_beta_customer/Screen/home.dart';
import 'package:sell_beta_customer/Screen/Auth/login_page.dart';
import 'package:sell_beta_customer/Screen/Auth/sign_up_page.dart';
import 'package:sell_beta_customer/Screen/notification_page.dart';
import 'package:sell_beta_customer/landing.dart';

import 'Screen/Product/view_one_product.dart';
import 'Screen/Profile/profile_edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
ChangeNotifierProvider(create: (context)=> UserProvider()),
ChangeNotifierProvider(create: (context)=> UserProfileModel())
      ],
      child: MaterialApp(
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: 1),
              child: child!);
        },
        routes: {
          '/signUpPage': (context)=>SignUpPage(),
          '/loginPage': (context)=>LoginPage(),
          '/home': (context)=>Home(),
          '/profileEditPage': (context)=>ProfileEditPage(),
          '/categoriesPage': (context)=>CategoriesPage(),
          '/notificationPage': (context)=>NotificationPage(),
          '/productPage': (context)=>ProductPage(),
          '/viewSingleProductPage': (context)=>ViewSingleProductPage(),
          '/cartPage': (context)=>CartPage(),
        },
        home: Landing(),
      ),
    );
  }
}
