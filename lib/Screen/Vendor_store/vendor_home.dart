import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';
import 'package:sell_beta_customer/Screen/Product/view_one_product.dart';

class VendorHomePage extends StatefulWidget {
  final vendorId;
  const VendorHomePage({Key? key, this.vendorId}) : super(key: key);

  @override
  _VendorHomePageState createState() => _VendorHomePageState();
}

class _VendorHomePageState extends State<VendorHomePage> {
  List<Tab> tabs = <Tab>[
    Tab(text: 'Store'),
    Tab(text: 'New'),
    Tab(text: 'Promotions'),
    Tab(text: 'Customer Gal...'),
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Builder(builder: (context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            // Your code goes here.
            // To get index of current tab use tabController.index
          }
        });
        return Scaffold(
          backgroundColor: Color(0xffE5E5E5),
          body: FutureBuilder(
              future: Future.wait([
                getVendorDetails(widget.vendorId),
                getShopProduct(widget.vendorId),
              ]),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var pro = snapshot.data[1].data;
                  var vendor = snapshot.data[0].data;
                  return snapshot.data[0].status && snapshot.data[1].status
                      ? Container(
                          height: height,
                          width: width,
                          child: Column(
                            children: [
                              Container(
                                height: height * .4,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff000000),
                                          Color(0xff161616),
                                        ]),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        opacity: 0.3,
                                        image: NetworkImage(vendor[0].logo))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AppBar(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      leading: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.arrow_back_ios)),
                                      title: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.asset(
                                              "images/icon/rectangle1.png"),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width * .01,
                                              ),
                                              Icon(Icons.search),
                                              SizedBox(
                                                width: width * .02,
                                              ),
                                              Text("Search in store")
                                            ],
                                          )
                                        ],
                                      ),
                                      actions: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.more_vert))
                                      ],
                                    ),
                                    SizedBox(height: height * .029),
                                    ListTile(
                                      leading: Container(
                                        height: height * .1,
                                        width: width * .15,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(
                                                    vendor[0].logo))),
                                      ),
                                      title: Text(
                                        "Primo Space >",
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Text(
                                            "4.6/",
                                            style: GoogleFonts.inter(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffF7941D)),
                                          ),
                                          Text(
                                            "5",
                                            style: GoogleFonts.inter(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xffF7941D)),
                                          ),
                                          RatingBarIndicator(
                                            rating: 4,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Color(0xffF7941D),
                                            ),
                                            itemCount: 5,
                                            itemSize: 10.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      trailing: Container(
                                        height: height * .05,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              //background color of box
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.2),
                                                blurRadius: 25.0, // b
                                                spreadRadius: 5.0, //0
                                                offset: Offset(
                                                  15.0, // x
                                                  15.0, // y
                                                ),
                                              )
                                            ],
                                            gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color(0xffF15741),
                                                  Color(0xffF29F46)
                                                ]),
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.transparent),
                                              elevation:
                                                  MaterialStateProperty.all(0)),
                                          onPressed: () {},
                                          child: Text("Follow"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: height * .027),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: '97%',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.white),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'Positive Seller Ratings',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: '10.7%',
                                            style: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: Colors.white),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text: 'Followers',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * .02),
                                    TabBar(
                                        indicatorWeight: 5,
                                        indicatorPadding: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        indicatorColor: Color(0xffF7941D),
                                        tabs: tabs)
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(children: [
                                  //1
                                  pro.isNotEmpty
                                      ? ListView(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              1.3 / 2,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 16,
                                                          crossAxisCount: 3,
                                                        ),
                                                        itemCount:
                                                            pro.length >= 5
                                                                ? 4
                                                                : pro.length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          var prod = pro[index];

                                                          // bool wishlist = prod.wishlist.toLowerCase() == 'true';

                                                          return InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ViewSingleProductPage(
                                                                            productId:
                                                                                prod.productId,
                                                                            vendorId:
                                                                                prod.vendorId,
                                                                            subCatId:
                                                                                prod.subCategory,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(
                                                                                  10),
                                                                              topRight: Radius.circular(
                                                                                  10)),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage(prod.imgUrl))),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            prod.title.toString().toUpperCase(),
                                                                            style:
                                                                                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 11),
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            prod.tag.toString().toUpperCase(),
                                                                            style:
                                                                                GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 8),
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width * .01,
                                                                        ),
                                                                        Text(
                                                                          "${prod.purchasePriceCurrency} ${prod.salePrice}",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xffEA5524),
                                                                              fontSize: 11),
                                                                        ),
                                                                        Text(
                                                                          "    ${prod.discount}% OFF",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xff0F9D58),
                                                                              fontSize: 6),
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
                                                                              width: width * .01,
                                                                            ),
                                                                            Image.asset("images/icon/rating.png"),
                                                                            Text(
                                                                              prod.ratingTotal,
                                                                              style: GoogleFonts.inter(fontSize: 8),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width * .005,
                                                                            ),
                                                                            Text(
                                                                              "(261) - 3.9k Sold",
                                                                              style: GoogleFonts.inter(fontSize: 6),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          size:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * .03,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 22),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Just For you",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                maxCrossAxisExtent:
                                                                    200,
                                                                childAspectRatio:
                                                                    1.3 / 2,
                                                                crossAxisSpacing:
                                                                    13,
                                                                mainAxisSpacing:
                                                                    16),
                                                        itemCount:
                                                            pro.length >= 5
                                                                ? 4
                                                                : pro.length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          var prod = pro[index];

                                                          // bool wishlist = prod.wishlist.toLowerCase() == 'true';

                                                          return InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ViewSingleProductPage(
                                                                            productId:
                                                                                prod.productId,
                                                                            vendorId:
                                                                                prod.vendorId,
                                                                            subCatId:
                                                                                prod.subCategory,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        height *
                                                                            .2,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft: Radius.circular(
                                                                                10),
                                                                            topRight: Radius.circular(
                                                                                10)),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage(prod.imgUrl))),
                                                                  ),
                                                                  ListTile(
                                                                    dense: true,
                                                                    title: Text(
                                                                      prod.title
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              13),
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      prod.tag
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              11),
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                    // trailing:wishlist?Icon(Icons.favorite , color: Color(0xffEA5524),) :Icon(Icons.favorite_border),
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width * .05,
                                                                        ),
                                                                        Text(
                                                                          "${prod.purchasePriceCurrency} ${prod.salePrice}",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xffEA5524),
                                                                              fontSize: 13),
                                                                        ),
                                                                        Text(
                                                                          "    ${prod.discount}% OFF",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xff0F9D58),
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
                                                                              width: width * .05,
                                                                            ),
                                                                            Image.asset("images/icon/rating.png"),
                                                                            SizedBox(
                                                                              width: width * .01,
                                                                            ),
                                                                            Text(
                                                                              prod.ratingTotal,
                                                                              style: GoogleFonts.inter(fontSize: 8),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width * .01,
                                                                            ),
                                                                            Text(
                                                                              "(261) - 3.9k Sold",
                                                                              style: GoogleFonts.inter(fontSize: 8),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * .03,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),
//2
                                  pro.isNotEmpty
                                      ? ListView(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              1.3 / 2,
                                                          crossAxisSpacing: 10,
                                                          mainAxisSpacing: 16,
                                                          crossAxisCount: 3,
                                                        ),
                                                        itemCount:
                                                            pro.length >= 5
                                                                ? 4
                                                                : pro.length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          var prod = pro[index];

                                                          // bool wishlist = prod.wishlist.toLowerCase() == 'true';

                                                          return InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ViewSingleProductPage(
                                                                            productId:
                                                                                prod.productId,
                                                                            vendorId:
                                                                                prod.vendorId,
                                                                            subCatId:
                                                                                prod.subCategory,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 5,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(
                                                                                  10),
                                                                              topRight: Radius.circular(
                                                                                  10)),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.cover,
                                                                              image: NetworkImage(prod.imgUrl))),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        horizontal:
                                                                            5,
                                                                        vertical:
                                                                            5),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            prod.title.toString().toUpperCase(),
                                                                            style:
                                                                                GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 11),
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Text(
                                                                            prod.tag.toString().toUpperCase(),
                                                                            style:
                                                                                GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 8),
                                                                            maxLines:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width * .01,
                                                                        ),
                                                                        Text(
                                                                          "${prod.purchasePriceCurrency} ${prod.salePrice}",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xffEA5524),
                                                                              fontSize: 11),
                                                                        ),
                                                                        Text(
                                                                          "    ${prod.discount}% OFF",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xff0F9D58),
                                                                              fontSize: 6),
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
                                                                              width: width * .01,
                                                                            ),
                                                                            Image.asset("images/icon/rating.png"),
                                                                            Text(
                                                                              prod.ratingTotal,
                                                                              style: GoogleFonts.inter(fontSize: 8),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width * .005,
                                                                            ),
                                                                            Text(
                                                                              "(261) - 3.9k Sold",
                                                                              style: GoogleFonts.inter(fontSize: 6),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          size:
                                                                              10,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * .03,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 22),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "Just For you",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: GridView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                maxCrossAxisExtent:
                                                                    200,
                                                                childAspectRatio:
                                                                    1.3 / 2,
                                                                crossAxisSpacing:
                                                                    13,
                                                                mainAxisSpacing:
                                                                    16),
                                                        itemCount:
                                                            pro.length >= 5
                                                                ? 4
                                                                : pro.length,
                                                        itemBuilder:
                                                            (BuildContext ctx,
                                                                index) {
                                                          var prod = pro[index];

                                                          // bool wishlist = prod.wishlist.toLowerCase() == 'true';

                                                          return InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ViewSingleProductPage(
                                                                            productId:
                                                                                prod.productId,
                                                                            vendorId:
                                                                                prod.vendorId,
                                                                            subCatId:
                                                                                prod.subCategory,
                                                                          )));
                                                            },
                                                            child: Container(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        height *
                                                                            .2,
                                                                    width: double
                                                                        .infinity,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.only(
                                                                            topLeft: Radius.circular(
                                                                                10),
                                                                            topRight: Radius.circular(
                                                                                10)),
                                                                        image: DecorationImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            image: NetworkImage(prod.imgUrl))),
                                                                  ),
                                                                  ListTile(
                                                                    dense: true,
                                                                    title: Text(
                                                                      prod.title
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              13),
                                                                      maxLines:
                                                                          2,
                                                                    ),
                                                                    subtitle:
                                                                        Text(
                                                                      prod.tag
                                                                          .toString()
                                                                          .toUpperCase(),
                                                                      style: GoogleFonts.inter(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              11),
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                    // trailing:wishlist?Icon(Icons.favorite , color: Color(0xffEA5524),) :Icon(Icons.favorite_border),
                                                                  ),
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              width * .05,
                                                                        ),
                                                                        Text(
                                                                          "${prod.purchasePriceCurrency} ${prod.salePrice}",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xffEA5524),
                                                                              fontSize: 13),
                                                                        ),
                                                                        Text(
                                                                          "    ${prod.discount}% OFF",
                                                                          style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color(0xff0F9D58),
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
                                                                              width: width * .05,
                                                                            ),
                                                                            Image.asset("images/icon/rating.png"),
                                                                            SizedBox(
                                                                              width: width * .01,
                                                                            ),
                                                                            Text(
                                                                              prod.ratingTotal,
                                                                              style: GoogleFonts.inter(fontSize: 8),
                                                                            ),
                                                                            SizedBox(
                                                                              width: width * .01,
                                                                            ),
                                                                            Text(
                                                                              "(261) - 3.9k Sold",
                                                                              style: GoogleFonts.inter(fontSize: 8),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Icon(
                                                                          Icons
                                                                              .more_vert,
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              width * .03,
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(),

                                  Text("Coming Soon"),
                                  Text("Coming Soon"),
                                ]),
                              )
                            ],
                          ),
                        )
                      : Center(
                          child: Text("Something Went Wrong"),
                        );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return Loading();
                }
              }),
        );
      }),
    );
  }
}
