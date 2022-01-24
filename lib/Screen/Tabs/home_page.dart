import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/icon_config.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Feeds/feeds.dart';
import 'package:sell_beta_customer/Screen/Orders/order_list.dart';
import 'package:sell_beta_customer/Screen/Profile/profile_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  logoutUser(userId) async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }


  DrawerIcon _drawerIcon = DrawerIcon();
  var font1 = GoogleFonts.inter(
      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white);
  var font2 = GoogleFonts.inter(
      fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      drawer: Container(
        child: Drawer(
          child: ListView(
            children: [
              Column(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(color: Color(0xffF07221)),
                      child: FutureBuilder(
                          future: userDetails(user.userId),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data.data;
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileEditPage()));
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                        data.profilePhotoUrl != null?
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:NetworkImage(data.profilePhotoUrl),
                                          ):
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundImage:AssetImage(_drawerIcon.sampleIcon),
                                          ),
                                          SizedBox(
                                            width: width * .04,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("${data.username ?? "No User"}" , style: font1,),
                                              Text("${data.email ?? "No Email"}" , style: font2,),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return Container();
                            }
                          })),
                  ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      DrawerListTile(
                        url: _drawerIcon.homeIcon,
                        title: 'Home',
                      ),
                      DrawerListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileEditPage()));
                        },
                        url: _drawerIcon.userIcon,
                        title: 'My Profile',
                      ),
                      DrawerListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> OrderListPage()));
                        },
                        url: _drawerIcon.categoryIcon,
                        title: 'My Orders',
                      ),
                      DrawerListTile(
                        onTap: (){
                          Navigator.pushNamed(context, '/categoriesPage');
                        },
                        url: _drawerIcon.categoryIcon,
                        title: 'Categories',
                      ),
                      DrawerListTile(
                        url: _drawerIcon.escrowIcon,
                        title: 'Escrow',
                      ),
                      DrawerListTile(
                        url: _drawerIcon.walletIcon,
                        title: 'Wallet',
                      ),
                      DrawerListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> FeedsPage()));
                        },
                        url: _drawerIcon.feedsIcon,
                        title:'Feeds',
                      ),
                      DrawerListTile(
                        url: _drawerIcon.notificationIcon,
                        title:'Notification',
                      ),
                      DrawerListTile(
                        url: _drawerIcon.settingIcon,
                        title: 'Settings',
                      ),
                      DrawerListTile(
                        onTap: (){
                          logoutUser("");
                          Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
                        },
                        url: _drawerIcon.logoutIcon,
                        title: 'Sign Out',
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/back.png'))),
                child: Image.asset(
                  'images/back1.png',
                  fit: BoxFit.cover,
                ),
                width: width,
                height: 258,
              ),
              Container(
                width: width,
                height: 258,
                child: Column(
                  children: [
                    Container(
                      child: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        title: Row(
                          children: [
                            Image.asset(
                              "images/logo.png",
                              scale: 3,
                            ),
                            SizedBox(
                              width: width * .02,
                            ),
                            Image.asset('images/logo1.png')
                          ],
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/notificationPage');
                              },
                              icon:
                                  ImageIcon(AssetImage(_drawerIcon.notifyIcon))),
                          IconButton(
                              onPressed: () {},
                              icon: ImageIcon(
                                  AssetImage(_drawerIcon.setting1Icon))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Image.asset('images/search_box.png'),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Search",
                                style: font2,
                              ),
                            ),
                            Positioned(
                              right: 10,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset('images/Rectangle 2631.png'),
                                  Image.asset('images/Search.png'),
                                ],
                              ),
                            )
                          ],
                        ),
                        ImageIcon(
                          AssetImage('images/Wallet_alt_duotone.png'),
                          size: 40,
                          color: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('images/Group 7179.png'),
                          Image.asset('images/Group 7178.png'),
                          Image.asset('images/Group 7177.png'),
                          Image.asset('images/Group 7176.png'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
