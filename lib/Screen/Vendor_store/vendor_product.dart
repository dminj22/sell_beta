import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Product/view_one_product.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';

class VendorProducts extends StatefulWidget {
  final productData;
  final vendorId;

  const VendorProducts({Key? key, this.productData, this.vendorId})
      : super(key: key);

  @override
  _VendorProductsState createState() => _VendorProductsState();
}

class _VendorProductsState extends State<VendorProducts> {
  var controller = ExpandedTileController();

  var selectedType = "Best Match";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    return ListView(
      children: [
        FutureBuilder(
            future: getShopProduct(widget.vendorId),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var pro = snapshot.data.data;
                print(pro);
                return Container(
                  child: Column(
                    children: [
                      ExpandedTile(
                          theme: ExpandedTileThemeData(
                              contentBackgroundColor: Colors.white),
                          title: Text(
                            "$selectedType",
                            style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(primaryColor)),
                          ),
                          trailing: Row(
                            children: [
                              Icon(Icons.share),
                              SizedBox(
                                width: width * .01,
                              ),
                              Icon(Icons.category),
                            ],
                          ),
                          content: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  selectedType,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(primaryColor)),
                                ),
                                trailing: Icon(
                                  Icons.check,
                                  color: Color(primaryColor),
                                ),
                              ),
                              Divider(),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedType = "Price for to high";
                                    controller.collapse();
                                  });
                                },
                                title: Text("Price for to high"),
                              ),
                              ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedType = "Price high to low";
                                    controller.collapse();
                                  });
                                },
                                title: Text("Price high to low"),
                              ),
                            ],
                          ),
                          controller: controller),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Just For you",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            )),
                      ),
                      SizedBox(
                        height: 25,
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
                            itemCount: pro.length >= 5 ? 4 : pro.length,
                            itemBuilder: (BuildContext ctx, index) {
                              var prod = pro[index];

                              // bool wishlist = prod.wishlist.toLowerCase() == 'true';

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewSingleProductPage(
                                                productId: prod.productId,
                                                vendorId: prod.vendorId,
                                                subCatId: prod.subCategory,
                                              )));
                                },
                                child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height * .2,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10)),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    NetworkImage(prod.imgUrl))),
                                      ),
                                      ListTile(
                                        dense: true,
                                        title: Text(
                                          prod.title.toString().toUpperCase(),
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13),
                                          maxLines: 2,
                                        ),
                                        subtitle: Text(
                                          prod.tag.toString().toUpperCase(),
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
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
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: width * .05,
                                                ),
                                                Image.asset(
                                                    "images/icon/rating.png"),
                                                SizedBox(
                                                  width: width * .01,
                                                ),
                                                Text(
                                                  prod.ratingTotal,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 8),
                                                ),
                                                SizedBox(
                                                  width: width * .01,
                                                ),
                                                Text(
                                                  "(261) - 3.9k Sold",
                                                  style: GoogleFonts.inter(
                                                      fontSize: 8),
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
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })
      ],
    );
  }
}
