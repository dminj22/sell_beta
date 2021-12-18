import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/icon_config.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AccountIcon _accountIcon = AccountIcon();

  var font = GoogleFonts.mulish(
      fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
  var font1 = GoogleFonts.mulish(
      fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white);
  var font2 = GoogleFonts.mulish(
      fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var userProfile = Provider.of<UserProfileModel>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xffF15741),
                    Color(0xffF15741),
                    Color(0xffF29F46),
                  ],
                )),
                child: Column(
                  children: [
                    AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
//todo work Here
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      ),
                      title: Text("Profile"),
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                                AssetImage(_accountIcon.notifyIcon)))
                      ],
                    ),
                    FutureBuilder(
                        future: userDetails(user.userId),
                        builder: (BuildContext context,
                            AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data.data;
                            //data store
                            userProfile.name = data.username;
                            userProfile.emailId = data.email;
                            userProfile.number = data.phone;
                            userProfile.address = data.address1;
                            userProfile.country = data.country;
                            userProfile.city = data.city;
                            userProfile.zip = data.zip;
                            userProfile.image = data.profilePhotoUrl;
                            return ListTile(
                              leading: data.profilePhotoUrl != null?
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:NetworkImage(data.profilePhotoUrl),
                              ):
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:AssetImage(_accountIcon.sampleIcon),
                              ),
                              title: Text(
                                "${data.username}",
                                style: font,
                              ),
                              subtitle: Text(
                                "${data.email}",
                                style: font,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/profileEditPage');
                                  },
                                  icon: ImageIcon(
                                    AssetImage(_accountIcon.editIcon),
                                    color: Colors.white,
                                  )),
                            );
                          } else if (snapshot.hasError) {
                            return Icon(Icons.error_outline);
                          } else {
                            return Container();
                          }
                        })
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: height * 9,
                  ),
                  Container(
                    height: height * .05,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xffF15741),
                        Color(0xffF15741),
                      ],
                    )),
                  ),
                  Container(
                    height: height * .75,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          width: width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    AccountListTile(
                                      title: "My Stores",
                                      url: _accountIcon.messageIcon,
                                    ),
                                    AccountListTile(
                                      title: "Payment History",
                                      url: _accountIcon.walletIcon,
                                    ),
                                    AccountListTile(
                                      title: "View All Orders",
                                      url: _accountIcon.bagIcon,
                                    ),
                                    AccountListTile(
                                      title: "Escrow",
                                      url: _accountIcon.escrowIcon,
                                    ),
                                    AccountListTile(
                                      title: "Settings",
                                      url: _accountIcon.settingIcon,
                                      noDivider: Container(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        Container(
                          width: width,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: height * .01,
                                    ),
                                    AccountListTile(
                                      title: "Privacy",
                                      url: _accountIcon.keyIcon,
                                    ),
                                    AccountListTile(
                                      title: "FAQ’S",
                                      url: _accountIcon.faqIcon,
                                    ),
                                    AccountListTile(
                                      title: "Rate Our App",
                                      url: _accountIcon.starIcon,
                                    ),
                                    AccountListTile(
                                      title: "Review",
                                      url: _accountIcon.star2Icon,
                                    ),
                                    AccountListTile(
                                      title: "Sign Out",
                                      url: _accountIcon.logoutIcon,
                                      noDivider: Container(),
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "V1.00",
                              style: TextStyle(color: Color(0xffC4C4C4)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(height: 10,)
            ],
          ),
        ],
      ),
    );
  }
}
