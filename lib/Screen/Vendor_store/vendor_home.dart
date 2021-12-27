import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';
import 'package:sell_beta_customer/Screen/Product/view_one_product.dart';
import 'package:sell_beta_customer/Screen/Vendor_store/vendor_categories.dart';
import 'package:sell_beta_customer/Screen/Vendor_store/vendor_feeds.dart';
import 'package:sell_beta_customer/Screen/Vendor_store/vendor_product.dart';
import 'package:sell_beta_customer/Screen/Vendor_store/vendor_profile.dart';

class VendorHomePage extends StatefulWidget {
  final vendorId;
  const VendorHomePage({Key? key, this.vendorId}) : super(key: key);

  @override
  _VendorHomePageState createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);




  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      VendorProfile(vendorId: widget.vendorId, hideTab: true,),
      VendorProfile(vendorId: widget.vendorId, hideTab: false, showData: VendorProducts(vendorId: widget.vendorId,),),
      VendorProfile(vendorId: widget.vendorId, hideTab: false, showData: VendorCategories(),),
      VendorProfile(vendorId: widget.vendorId, hideTab: false, showData: VendorFeeds(),),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed),
            label: 'Feeds',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
