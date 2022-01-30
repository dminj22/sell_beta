import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/add_to_cart_model.dart';
import 'package:sell_beta_customer/Api/model/follow_vendor_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/delivery.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/service.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/specification.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/variation_bottom.dart';
import 'package:sell_beta_customer/Config/theme.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sell_beta_customer/Screen/Vendor_store/vendor_home.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class ViewSingleProductPage extends StatefulWidget {
  final productId;
  final price;
  final vendorId;
  final subCatId;

  const ViewSingleProductPage(
      {Key? key, this.productId, this.price, this.vendorId, this.subCatId})
      : super(key: key);

  @override
  _ViewSingleProductPageState createState() => _ViewSingleProductPageState();
}

class _ViewSingleProductPageState extends State<ViewSingleProductPage> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  int? selectedSize;

  var selectedColor;

  String? sizeValue;

  _addToCart(userId, prodId, price, vendorId, quantity, size, color) async {
    try {
      if (selectedColor != null && selectedSize != null) {
        if (userId != null &&
            prodId != null &&
            price != null &&
            vendorId != null &&
            quantity != null &&
            size != null &&
            color != null) {
          AddToCartModel? model = await addToCart(
              userId, vendorId, prodId, quantity, price, size, color);
          if (model!.status) {
            showSnackBar(context, model.message);
          } else {
            showSnackBar(context, model.message);
          }
        } else {
          showSnackBar(context, "Something Went Wrong");
        }
      } else {
        showSnackBar(context, "Select Size and Color");
      }
    } catch (e) {
      print(e);
    }
  }

  _showDelivery() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return DeliveryModel();
        });
  }

  _showService() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return ServiceModel();
        });
  }

  _showSpecification(proData) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return SpecificationBottomModel(
            proData: proData,
          );
        });
  }

  _showVariation(proColor, proSize, proData) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return VariationBottom(
            proColor: proColor,
            proSize: proSize,
            proData: proData,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    var font1 = GoogleFonts.inter(fontWeight: FontWeight.bold);
    var font2 = GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 10);

    return Scaffold(
      body: FutureBuilder(
          future: Future.wait([
            getSingleProduct(widget.productId, user.userId),
            getSingleProductImage(widget.productId),
            getShopProduct(widget.vendorId),
            getCartList(user.userId),
            getVendorDetails(widget.vendorId, user.userId),
            productReview(widget.productId),
            getRelatedProduct(widget.subCatId)
          ]),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data[0].data;
              var item = snapshot.data[1].data;
              var pro = snapshot.data[2].data;
              var vendor = snapshot.data[4].data;
              var review = snapshot.data[5].data;
              var relPro = snapshot.data[6].data;
              var image = [];

              if (data != null && item != null) {
                var a = item.map((i) => {image.add(i.imgUrl)});
                print(a);
              }

              // print(
              //     "Product Data = ${snapshot.data[0].status}\n Image Data = ${snapshot.data[1].status} \n Vendor Product Data = ${snapshot.data[2].status} \n"
              //     "Vendor Detail Data = ${snapshot.data[4].status} \n Review Data = ${snapshot.data[5].status} \n Related Products Data = ${snapshot.data[6].status} \n"
              //     "");

              return data != null
                  ? Scaffold(
                      backgroundColor: Color(0xffE5E5E5),
                      bottomSheet: Container(
                        height: height * .1,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * .03,
                            ),
                            ImageIcon(
                              AssetImage("images/icon/messages.png"),
                              size: 40,
                              color: Color(0xffF15741),
                            ),
                            SizedBox(
                              width: width * .03,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              child: ImageIcon(
                                AssetImage("images/icon/shop.png"),
                                size: 40,
                                color: Color(0xffF15741),
                              ),
                            ),
                            SizedBox(
                              width: width * .03,
                            ),
                            Expanded(
                              child: CustomButtons(
                                onPressed: () {
                                  var userId = user.userId;
                                  var prodId = data[0].productId;
                                  var price = "${data[0].salePrice}";
                                  var vendorId = data[0].vendorId;
                                  var quantity = "1";
                                  var size = "$sizeValue";
                                  var color = "$selectedColor";
                                  _addToCart(userId, prodId, price, vendorId,
                                      quantity, size, color);
                                },
                                text: "Add to Cart",
                                color: [Color(0xffF15741), Color(0xffF29F46)],
                              ),
                            ),
                            SizedBox(
                              width: width * .03,
                            ),
                            Expanded(
                              child: CustomButtons(
                                text: "Buy Now",
                                color: [Color(0xffF15741), Color(0xffF29F46)],
                              ),
                            ),
                            SizedBox(
                              width: width * .03,
                            )
                          ],
                        ),
                      ),
                      body: ListView(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: height / 2,
                                child: Column(children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      snapshot.data[1].status
                                          ? CarouselSlider(
                                              items: image
                                                  .map((item) => Container(
                                                        child: CustomImage(
                                                          url: item,
                                                        ),
                                                      ))
                                                  .toList(),
                                              carouselController: _controller,
                                              options: CarouselOptions(
                                                  aspectRatio: 1.0,
                                                  viewportFraction: 1.0,
                                                  onPageChanged:
                                                      (index, reason) {
                                                    setState(() {
                                                      _current = index;
                                                    });
                                                  }),
                                            )
                                          : Center(
                                              child:
                                                  Text("No Image Available")),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: image
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                return GestureDetector(
                                                  onTap: () => _controller
                                                      .animateToPage(entry.key),
                                                  child: Container(
                                                    width: 12.0,
                                                    height: 12.0,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8.0,
                                                            horizontal: 4.0),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: (Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Colors.white
                                                                : Color(
                                                                    0xffF15741))
                                                            .withOpacity(
                                                                _current ==
                                                                        entry
                                                                            .key
                                                                    ? 1
                                                                    : .4)),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                              AppBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                leading: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(.3),
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/cartPage');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.black.withOpacity(.3),
                                        child: ImageIcon(
                                          AssetImage('images/icon/cart.png'),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          Colors.black.withOpacity(.3),
                                      child: Icon(
                                        Icons.more_vert,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 30),
                                    child: Container(
                                      width: width * .18,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: Color(0xffF7941D),
                                              size: 20,
                                            ),
                                            Text(
                                              data[0].ratingTotal ?? "",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "${data[0].shippingCostCurrency ?? ""} ${data[0].salePrice ?? ""}",
                                            style: GoogleFonts.roboto(
                                                color: Color(0xffEA5524),
                                                fontWeight: FontWeight.w700,
                                                fontSize: 22),
                                          ),
                                          Text(
                                            '${data[0].discount ?? ""}% OFF',
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                color: Color(0xff0F9D58)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: data[0].wishlist == "true"
                                                  ? Icon(Icons
                                                      .favorite_border_outlined)
                                                  : Icon(
                                                      Icons.favorite,
                                                      color:
                                                          Color(primaryColor),
                                                    )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.share)),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * .03,
                              ),
                              ListTile(
                                title: Text(
                                    "${data[0].title ?? ""}".toUpperCase()),
                                subtitle: Html(
                                  data: data[0].description ?? "",
                                ),
                              ),
                              data[0].productColors.isNotEmpty
                                  ? Container(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                              _showVariation(
                                                  data[0].productColors,
                                                  data[0].size,
                                                  data[0]);
                                            },
                                            title: Text("Variations"),
                                            trailing: Text("View All >"),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Wrap(
                                                children: data[0]
                                                    .productColors
                                                    .map<Widget>((e) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: OutlinedButton(
                                                            style: ButtonStyle(
                                                                side: MaterialStateProperty.all(BorderSide(
                                                                    color: selectedColor ==
                                                                            e
                                                                                .color
                                                                        ? Color(
                                                                            primaryColor)
                                                                        : Colors
                                                                            .grey))),
                                                            onPressed: () {
                                                              setState(() {
                                                                selectedColor =
                                                                    e.color;
                                                              });
                                                            },
                                                            child: Text(
                                                              e.color,
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: selectedColor == e.color
                                                                      ? Color(
                                                                          primaryColor)
                                                                      : Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),
                              data[0].size != ""
                                  ? Container(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text("Sizes "),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Wrap(
                                                alignment: WrapAlignment.end,
                                                children: data[0]
                                                    .size
                                                    .toString()
                                                    .split(",")
                                                    .asMap()
                                                    .entries
                                                    .map((e) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4),
                                                          child: OutlinedButton(
                                                            style: ButtonStyle(
                                                                side: MaterialStateProperty.all(BorderSide(
                                                                    color: selectedSize ==
                                                                            e
                                                                                .key
                                                                        ? Color(
                                                                            primaryColor)
                                                                        : Colors
                                                                            .grey))),
                                                            onPressed: () {
                                                              setState(() {
                                                                selectedSize =
                                                                    e.key;
                                                                sizeValue =
                                                                    e.value;
                                                              });
                                                            },
                                                            child: Text(
                                                              "${e.value}",
                                                              style: GoogleFonts.poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
                                                                  color: selectedSize ==
                                                                          e.key
                                                                      ? Color(
                                                                          primaryColor)
                                                                      : Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              ListTile(
                                onTap: () {
                                  _showDelivery();
                                },
                                title: Text("Delivery"),
                                // subtitle: Text(
                                //     "Standard Delivery (2 - ${data[0].deliveryDays} days)"),
                                trailing: Text("View All >"),
                              ),
                              ListTile(
                                onTap: () {
                                  _showService();
                                },
                                title: Text("Services"),
                                subtitle: Text("7 days easy refund to seller"),
                                trailing: Text("View All >"),
                              ),
                              ListTile(
                                onTap: () {
                                  _showSpecification(data[0]);
                                },
                                title: Text("Specification"),
                                trailing: Text("View All >"),
                              ),
                            ],
                          ),
                          //ratings and review
                          Divider(),
                          snapshot.data[5].status
                              ? Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text("Ratings & Reviews "),
                                        trailing: Text("View All>"),
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text("3/5"),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            RatingBarIndicator(
                                              rating: double.parse(
                                                  vendor[0].ratingTotal ??
                                                      "0.0"),
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              direction: Axis.horizontal,
                                            )
                                          ],
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        itemCount: snapshot.data[5].data.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Column(
                                            children: [
                                              ListTile(
                                                leading: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      review[index]
                                                          .profilePhotoUrl),
                                                ),
                                                title: Text(
                                                    "${review[index].username}"),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${review[index].comment}"),
                                                    Row(
                                                      children: [
                                                        RatingBarIndicator(
                                                          rating: double.parse(
                                                              review[index]
                                                                  .rating),
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          itemCount: 5,
                                                          itemSize: 10.0,
                                                          direction:
                                                              Axis.horizontal,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                            "${review[index].rating}"),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  child: Center(child: Text("No Review")),
                                ),

                          //shop Products

                          snapshot.data[2].status
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Card(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          vendor != null
                                              ? Container(
                                                  child: ListTile(
                                                    leading: Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: CustomImage(
                                                          url: vendor[0].logo),
                                                    ),
                                                    title: Text(
                                                        "${vendor[0].company}"),
                                                    subtitle:
                                                        RatingBarIndicator(
                                                      rating: double.parse(
                                                          vendor[0]
                                                                  .ratingTotal ??
                                                              "0.0"),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      itemCount: 5,
                                                      itemSize: 10.0,
                                                      direction:
                                                          Axis.horizontal,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          vendor != null
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "90%",
                                                                style: font1,
                                                              ),
                                                              Text(
                                                                "Positive Seller Rating",
                                                                style: font2,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "90%",
                                                                style: font1,
                                                              ),
                                                              Text(
                                                                "Ship On Time",
                                                                style: font2,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "90%",
                                                                style: font1,
                                                              ),
                                                              Text(
                                                                "Chat Response Rate",
                                                                style: font2,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          vendor != null
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xffEA5524),
                                                              width: 1,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      onPressed: () async {
                                                        var userId =
                                                            "${user.userId}";
                                                        var vendorId =
                                                            "${widget.vendorId}";
                                                        var type =
                                                            vendor[0].follow ==
                                                                    "false"
                                                                ? "Follow"
                                                                : "UnFollow";
                                                        FollowVendorModel?
                                                            model =
                                                            await followVendor(
                                                                userId,
                                                                vendorId,
                                                                type);
                                                        if (model!.status ==
                                                            true) {
                                                          setState(() {});
                                                          showToast(
                                                              model.message);
                                                        } else {
                                                          setState(() {});
                                                          showToast(
                                                              model.message);
                                                        }
                                                      },
                                                      child: Text(
                                                          vendor[0].follow ==
                                                                  "false"
                                                              ? "Follow"
                                                              : "UnFollow"),
                                                    ),
                                                    OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xffEA5524),
                                                              width: 2,
                                                              style: BorderStyle
                                                                  .solid),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        VendorHomePage(
                                                                          vendorId:
                                                                              widget.vendorId,
                                                                        )));
                                                      },
                                                      child: Text("Visit"),
                                                    ),
                                                  ],
                                                )
                                              : Container(),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: GridView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
                                                        childAspectRatio:
                                                            1.3 / 2,
                                                        crossAxisSpacing: 13,
                                                        mainAxisSpacing: 16),
                                                itemCount: pro.length >= 5
                                                    ? 4
                                                    : pro.length,
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
                                                                    vendorId: prod
                                                                        .vendorId,
                                                                    subCatId: prod
                                                                        .subCategory,
                                                                  )));
                                                    },
                                                    child: Container(
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            flex: 6,
                                                            child: CustomImage(
                                                              url: prod.imgUrl,
                                                            ),
                                                          ),
                                                          ListTile(
                                                            dense: true,
                                                            title: Text(
                                                              prod.title
                                                                  .toString()
                                                                  .toUpperCase(),
                                                              style: GoogleFonts.inter(
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
                                                              style: GoogleFonts.inter(
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
                                                                  width: width *
                                                                      .05,
                                                                ),
                                                                Text(
                                                                  "${prod.purchasePriceCurrency} ${prod.salePrice}",
                                                                  style: GoogleFonts.inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xffEA5524),
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                                Text(
                                                                  "    ${prod.discount}% OFF",
                                                                  style: GoogleFonts.inter(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xff0F9D58),
                                                                      fontSize:
                                                                          9),
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
                                                                          width *
                                                                              .05,
                                                                    ),
                                                                    Image.asset(
                                                                        "images/icon/rating.png"),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              .01,
                                                                    ),
                                                                    Text(
                                                                      prod.ratingTotal,
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              8),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          width *
                                                                              .01,
                                                                    ),
                                                                    Text(
                                                                      "(261) - 3.9k Sold",
                                                                      style: GoogleFonts.inter(
                                                                          fontSize:
                                                                              8),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .more_vert,
                                                                  size: 12,
                                                                ),
                                                                SizedBox(
                                                                  width: width *
                                                                      .03,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                              : Container(),
                          snapshot.data[6].status
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: height * .03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            width: 36,
                                            child: Divider(
                                              thickness: 2,
                                              color: Color(primaryColor),
                                            )),
                                        SizedBox(
                                          width: width * .03,
                                        ),
                                        Text(
                                          "Products you may like",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Color(primaryColor)),
                                        ),
                                        SizedBox(
                                          width: width * .03,
                                        ),
                                        SizedBox(
                                            width: 36,
                                            child: Divider(
                                              thickness: 2,
                                              color: Color(primaryColor),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * .03,
                                    ),
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
                                          itemCount: relPro.length >= 5
                                              ? 4
                                              : relPro.length,
                                          itemBuilder:
                                              (BuildContext ctx, index) {
                                            var rData = relPro[index];
                                            // bool wishlist = prod.wishlist.toLowerCase() == 'true';
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewSingleProductPage(
                                                              productId: rData
                                                                  .productId,
                                                              subCatId: rData
                                                                  .subCategory,
                                                              vendorId: rData
                                                                  .vendorId,
                                                            )));
                                              },
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Expanded(
                                                        flex: 7,
                                                        child: CustomImage(
                                                            url: rData.imgUrl)),
                                                    ListTile(
                                                      dense: true,
                                                      title: Text(
                                                        rData.title
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
                                                        rData.tag
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
                                                            "${rData.purchasePriceCurrency} ${rData.salePrice}",
                                                            style: GoogleFonts.inter(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xffEA5524),
                                                                fontSize: 13),
                                                          ),
                                                          Text(
                                                            "    ${rData.discount}% OFF",
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
                                                                rData
                                                                    .ratingTotal,
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
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: height * .1,
                          )
                        ],
                      ),
                    )
                  : Center(child: Text("error"));
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Loading();
            }
          }),
    );
  }
}
