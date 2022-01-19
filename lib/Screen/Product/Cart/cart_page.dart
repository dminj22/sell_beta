import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/cart_update_quantity_model.dart';
import 'package:sell_beta_customer/Api/model/delete_cart_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Product/create_order/create_order.dart';
import 'package:sell_beta_customer/Screen/Product/view_one_product.dart';

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

  var selectPrice = [];

  Future<void> _showMyDialog(noOfDel, onPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          title: const Text('Confirm to delete?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Are you sure want to delete this $noOfDel item(s) From cart?'),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Color(primaryColor)),
                  ),
                )),
            SizedBox(
              width: 100,
              child: CustomButtons(
                onPressed: onPressed,
                color: [Color(0xffF15741), Color(0xffF29F46)],
                text: "Delete",
              ),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  dynamic totalPrice = 0;
  dynamic finalPrice = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          title: Row(
            children: [
              Text("Cart "),
              deleteItem.isNotEmpty
                  ? Container(
                      width: 35,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(primaryColor).withOpacity(.6)),
                      child: Center(
                          child: Text(
                        "${deleteItem.length}",
                        style: GoogleFonts.inter(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      )),
                    )
                  : Container(),
            ],
          ),
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
                          _showMyDialog("${multiDelete.length}", () async {
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
                          });
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
                var data = snapshot.data.data;

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
                   if(selectPrice.contains(i)){
                     totalPrice += itemNo[i] * price[i];
                   }
                  }
                  newChange = false;
                } else {
                  print("nothing");
                }

                return Scaffold(
                  bottomSheet: snapshot.data.status &&
                          snapshot.data.data.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 19),
                          child: Card(
                            child: ListTile(
                              title: Text("Total:"),
                              subtitle: Text(totalPrice !=0?"${snapshot.data.data[0].productList.salePriceCurrency} $totalPrice":"Select Product"),
                              trailing: SizedBox(
                                width: 100,
                                child: CustomButtons(
                                  onPressed: () {
                                    if (multiDelete.isNotEmpty) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateOrderPage(
                                                    createOrderData:
                                                        multiDelete,
                                                    price: totalPrice,
                                                  )));
                                    } else {
                                      showToast("Select Product");
                                    }
                                  },
                                  color: [Color(0xffF15741), Color(0xffF29F46)],
                                  text: "Check Out",
                                ),
                              ),
                            ),
                          ),
                        )
                      : Text(""),
                  body: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      snapshot.data.status && snapshot.data.data.isNotEmpty
                          ? Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                  if (deleteItem.contains(
                                                      snapshot.data.data[index]
                                                          .cartId)) {
                                                    deleteItem.remove(snapshot
                                                        .data
                                                        .data[index]
                                                        .cartId);

                                                    multiDelete.remove(
                                                        "cart_id[$index]");
                                                    selectPrice.remove(index);
                                                    newChange = true;
                                                  } else {
                                                    deleteItem.add(snapshot.data
                                                        .data[index].cartId);
                                                    multiDelete.addAll({
                                                      "cart_id[$index]":
                                                          "${snapshot.data.data[index].cartId}"
                                                    });
                                                    selectPrice.add(index);
                                                    newChange = true;
                                                  }
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 13,
                                                        vertical: 11),
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
                                                                image: NetworkImage(item
                                                                    .productList
                                                                    .thumbImage)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: SizedBox(
                                                              height: 24.0,
                                                              width: 24.0,
                                                              child: Checkbox(
                                                                activeColor: Color(
                                                                    0xffF15741),
                                                                onChanged: (bool?
                                                                    value) {},
                                                                value:
                                                                    selectItem[
                                                                        index],
                                                              ),
                                                            )),
                                                      )
                                                    : Container(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: SizedBox(
                                                              height: 24.0,
                                                              width: 24.0,
                                                              child: Checkbox(
                                                                activeColor: Color(
                                                                    0xffF15741),
                                                                onChanged: (bool?
                                                                    value) {},
                                                                value:
                                                                    selectItem[
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
                                                                color: Colors
                                                                    .grey),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
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
                                                      "Size - ${item.size} Brands:${item.productList.brandName}",
                                                      style: GoogleFonts.inter(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xffC4C4C4)),
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
                                                                  FontWeight
                                                                      .w700,
                                                              color: Color(
                                                                  0xffF15741)),
                                                        ),
                                                        InkWell(
                                                            onTap: () async {
                                                              if (itemNo[
                                                              index] >
                                                                  1) {
                                                               setState(() {
                                                                 itemNo[index] =
                                                                     itemNo[index] -
                                                                         1;
                                                                 newChange =
                                                                 true;
                                                               });
                                                              }
                                                              if (newChange) {
                                                                var cartId =
                                                                    "${data[index].cartId}";
                                                                var quantity =
                                                                    "${itemNo[index]}";
                                                                var newPrice =
                                                                    "${double.parse(item.productList.salePrice) * itemNo[index]}";
                                                                CartUpdateQuantityModel?
                                                                model =
                                                                    await updateCartQuantity(
                                                                    cartId,
                                                                    quantity,
                                                                    newPrice);
                                                                if (model!
                                                                    .status ==
                                                                    true) {
                                                                  showToast(
                                                                      "Updated");
                                                                } else {}
                                                              }
                                                            },
                                                            child: ImageIcon(
                                                                AssetImage(
                                                                    "images/icon/minus-square.png"))),
                                                        Text(itemNo[index]
                                                            .toString()),
                                                        InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                itemNo[index] =
                                                                    itemNo[index] +
                                                                        1;
                                                                newChange =
                                                                    true;
                                                              });
                                                              if (newChange) {
                                                                var cartId =
                                                                    "${data[index].cartId}";
                                                                var quantity =
                                                                    "${itemNo[index]}";
                                                                var newPrice =
                                                                    "${double.parse(item.productList.salePrice) * itemNo[index]}";
                                                                CartUpdateQuantityModel?
                                                                    model =
                                                                    await updateCartQuantity(
                                                                        cartId,
                                                                        quantity,
                                                                        newPrice);
                                                                if (model!
                                                                        .status ==
                                                                    true) {
                                                                  showToast(
                                                                      "Updated");
                                                                } else {}
                                                              }
                                                            },
                                                            child: ImageIcon(
                                                              AssetImage(
                                                                  "images/icon/add-square.png"),
                                                              color: Color(
                                                                  0xffF15741),
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
                                )
                              ],
                            )
                          : NoItem()
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}

class NoItem extends StatelessWidget {
  const NoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var font1 = GoogleFonts.inter(fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 10);

    var user = Provider.of<UserProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
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
                )),
            FutureBuilder(
                future: getShopProduct(4),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var pro = snapshot.data.data;
                    return snapshot.data.status
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: GridView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                                  maxCrossAxisExtent: 200,
                                                  childAspectRatio: 1.3 / 2,
                                                  crossAxisSpacing: 13,
                                                  mainAxisSpacing: 16),
                                          itemCount:
                                              pro.length >= 5 ? 4 : pro.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            var prod = pro[index];

                                            // bool wishlist = prod.wishlist.toLowerCase() == 'true';

                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewSingleProductPage(
                                                              productId: prod
                                                                  .productId,
                                                              vendorId:
                                                                  prod.vendorId,
                                                              subCatId: prod
                                                                  .subCategory,
                                                            )));
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: height * .2,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10)),
                                                          image: DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image: NetworkImage(
                                                                  prod.imgUrl))),
                                                    ),
                                                    ListTile(
                                                      dense: true,
                                                      title: Text(
                                                        prod.title
                                                            .toString()
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 13),
                                                        maxLines: 2,
                                                      ),
                                                      subtitle: Text(
                                                        prod.tag
                                                            .toString()
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 11),
                                                        maxLines: 1,
                                                      ),
                                                      // trailing:wishlist?Icon(Icons.favorite , color: Color(0xffEA5524),) :Icon(Icons.favorite_border),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: width * .05,
                                                          ),
                                                          Text(
                                                            "${prod.purchasePriceCurrency} ${prod.salePrice}",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xffEA5524),
                                                                fontSize: 13),
                                                          ),
                                                          Text(
                                                            "    ${prod.discount}% OFF",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xff0F9D58),
                                                                fontSize: 9),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width:
                                                                    width * .05,
                                                              ),
                                                              Image.asset(
                                                                  "images/icon/rating.png"),
                                                              SizedBox(
                                                                width:
                                                                    width * .01,
                                                              ),
                                                              Text(
                                                                prod.ratingTotal,
                                                                style: GoogleFonts
                                                                    .inter(
                                                                        fontSize:
                                                                            8),
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    width * .01,
                                                              ),
                                                              Text(
                                                                "(261) - 3.9k Sold",
                                                                style: GoogleFonts
                                                                    .inter(
                                                                        fontSize:
                                                                            8),
                                                              ),
                                                            ],
                                                          ),
                                                          Icon(
                                                            Icons.more_vert,
                                                            size: 12,
                                                          ),
                                                          SizedBox(
                                                            width: width * .03,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container();
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return CircularProgressIndicator();
                  }
                })
          ],
        ),
      ),
    );
  }
}
