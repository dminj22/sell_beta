import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/delete_cart_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var itemNo = [];
  var selectItem = [];
  var deleteItem = [];
  var price = [];

  Map<String, String> multiDelete = {};

  dynamic newChange;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  dynamic totalPrice = 0;

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
          deleteItem.isNotEmpty
              ? Stack(
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
                    InkWell(
                      onTap: () async {
                        multiDelete.addAll({"user_id": "${user.userId}"});
                        DeleteCartModel? model =
                            await deleteCartItem(multiDelete);
                        if (model!.status == true) {
                          setState(() {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartPage()));
                          });
                          showSnackBar(context, model.message);
                        } else {
                          showSnackBar(context, model.message);
                        }
                      },
                      child: ImageIcon(
                        AssetImage('images/icon/delete.png'),
                        color: Color(0xffEA5524),
                        size: 20,
                      ),
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            width: width * .03,
          )
        ],
      ),
      body: FutureBuilder(
          future: getCartList(user.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.status) {
                if (itemNo.isEmpty) {
                  itemNo = snapshot.data.data
                      .map((e) => int.parse(e.quantity))
                      .toList();
                  selectItem = snapshot.data.data.map((i) => false).toList();
                  price = snapshot.data.data
                      .map((i) => double.parse(i.productList.salePrice))
                      .toList();
                }
              } else {}

              if (newChange == null || newChange) {
                totalPrice = 0;
                for (var i = 0; i < itemNo.length; i++) {
                  totalPrice += itemNo[i] * price[i];
                }
                newChange = false;
              } else {
                print("nothing");
              }

              return ListView(
                children: [
                  snapshot.data.status
                      ? Column(
                          children: [
                            ListView.builder(
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
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectItem[index] =
                                                  !selectItem[index];
                                              if (deleteItem.contains(snapshot
                                                  .data.data[index].cartId)) {
                                                deleteItem.remove(snapshot
                                                    .data.data[index].cartId);

                                                multiDelete
                                                    .remove("cart_id[$index]");
                                                print(multiDelete);
                                              } else {
                                                deleteItem.add(snapshot
                                                    .data.data[index].cartId);
                                                multiDelete.addAll({
                                                  "cart_id[$index]":
                                                      "${snapshot.data.data[index].cartId}"
                                                });
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 13, vertical: 11),
                                            child: item.productList
                                                            .thumbImage !=
                                                        "" &&
                                                    item.productList
                                                            .thumbImage !=
                                                        null
                                                ? Container(
                                                    height: 98,
                                                    width: 98,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                item.productList
                                                                    .thumbImage)),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: SizedBox(
                                                          height: 24.0,
                                                          width: 24.0,
                                                          child: Checkbox(
                                                            activeColor: Color(
                                                                0xffF15741),
                                                            onChanged: (bool?
                                                                value) {},
                                                            value: selectItem[
                                                                index],
                                                          ),
                                                        )),
                                                  )
                                                : Container(
                                                    child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: SizedBox(
                                                          height: 24.0,
                                                          width: 24.0,
                                                          child: Checkbox(
                                                            activeColor: Color(
                                                                0xffF15741),
                                                            onChanged: (bool?
                                                                value) {},
                                                            value: selectItem[
                                                                index],
                                                          ),
                                                        )),
                                                    height: 98,
                                                    width: 98,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "images/sample/no_image.jpg")),
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                  ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              ListTile(
                                                minVerticalPadding: 0,
                                                title: Text(
                                                  "${item.productList.title}"
                                                      .toUpperCase(),
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
                                                      "${item.productList.salePriceCurrency ?? ""} ${double.parse(item.productList.salePrice) * itemNo[index]}",
                                                      style: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Color(
                                                              0xffF15741)),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (itemNo[index] >
                                                                1) {
                                                              itemNo[index] =
                                                                  itemNo[index] -
                                                                      1;
                                                              newChange = true;
                                                            }
                                                          });
                                                        },
                                                        child: ImageIcon(AssetImage(
                                                            "images/icon/minus-square.png"))),
                                                    Text(itemNo[index]
                                                        .toString()),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            itemNo[index] =
                                                                itemNo[index] +
                                                                    1;
                                                            newChange = true;
                                                            print(itemNo);
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
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 19),
                              child: Card(
                                child: ListTile(
                                  title: Text("Total:"),
                                  subtitle: Text(
                                      "${snapshot.data.data[0].productList.salePriceCurrency} $totalPrice"),
                                  trailing: SizedBox(
                                    width: 100,
                                    child: CustomButtons(
                                      color: [
                                        Color(0xffF15741),
                                        Color(0xffF29F46)
                                      ],
                                      text: "Check Out",
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : NoItem()
                ],
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

class NoItem extends StatelessWidget {
  const NoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        height: height * .3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("There are no items in this cart "),
            OutlinedButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        BorderSide(color: Color(0xffF15741)))),
                onPressed: () {},
                child: Text(
                  "Continue Shopping",
                  style: TextStyle(color: Color(0xffF15741)),
                )),
            Divider(),
            TextButton(
                onPressed: () {},
                child: Text(
                  "View my History",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
