import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Config/icon_config.dart';
import 'package:sell_beta_customer/Screen/Product/Cart/cart_page.dart';
import 'package:sell_beta_customer/Screen/Tabs/account_page.dart';
import 'package:sell_beta_customer/Screen/Tabs/home_page.dart';
import 'package:sell_beta_customer/Screen/Vendor_store/vendor_home.dart';


class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

int _selectedIndex = 0;
class _HomeState extends State<Home> {
  BottomNavIcon _navIcon = BottomNavIcon();

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
   AccountPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items:[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_navIcon.homeIcon)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_navIcon.feedsIcon)),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_navIcon.categoryIcon)),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_navIcon.cartIcon)),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage(_navIcon.accountIcon)),
            label: 'Account',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffEA5524),
        onTap: _onItemTapped,
      ),
    );
  }
}