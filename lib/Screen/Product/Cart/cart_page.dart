import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var num = 1;
  var noOfItem = [];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Cart "),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                Color(0xffEA5524),
                Color(0xffF7941D),
              ])),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    AssetImage('images/icon/rectangle.png'),
                    size: 30,
                  ),
                ],
              ),
              ImageIcon(
                AssetImage('images/icon/delete.png'),
                color: Color(0xffEA5524),
                size: 20,
              ),
            ],
          ),
          SizedBox(
            width: width * .03,
          )
        ],
      ),
      body: FutureBuilder(
          future: getCartList(user.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = snapshot.data.data[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 6),
                    child: Card(
                      elevation: 3,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 11),
                            child:
                            item.productList.thumbImage != "" && item.productList.thumbImage != null?
                            Container(
                              height: 98,
                              width: 98,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                      NetworkImage(
                                          item.productList.thumbImage)),
                                  border: Border.all(
                                      color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))),
                            ):Container(
                              height: 98,
                              width: 98,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                      AssetImage("images/sample/no_image.jpg")),
                                  border: Border.all(
                                      color: Colors.grey),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10))),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                ListTile(
                                  minVerticalPadding: 0,
                                  title: Text(
                                    "${item.productList.title}".toUpperCase(),
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight:
                                        FontWeight.w600),
                                  ),
                                  subtitle: Text(
                                    "Size - ${item.size}",
                                    style: GoogleFonts.inter(
                                        fontSize: 12,
                                        fontWeight:
                                        FontWeight.w400,
                                        color: Color(0xffC4C4C4)),
                                    maxLines: 1,
                                  ),
                                ),
                                ListTile(
                                  dense: true,
                                  title: Text(
                                    "Color - ${item.color}",
                                    style: GoogleFonts.inter(
                                        fontWeight:
                                        FontWeight.w600,
                                        fontSize: 10),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        "${item.productList.salePriceCurrency} ${item.productList.salePrice}",
                                        style: GoogleFonts.inter(
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Color(
                                                0xffF15741)),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              num = num - 1;
                                            });
                                          },
                                          child: ImageIcon(AssetImage(
                                              "images/icon/minus-square.png"))),
                                      Text(num.toString()),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              num = num + 1;
                                            });
                                          },
                                          child: ImageIcon(
                                            AssetImage(
                                                "images/icon/add-square.png"),
                                            color:
                                            Color(0xffF15741),
                                          ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Loading();
            }
          }),
    );
  }
}
