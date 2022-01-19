import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Screen/Product/view_one_product.dart';

class ProductPage extends StatefulWidget {
  final subCatId;
  const ProductPage({Key? key, this.subCatId}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Image.asset('images/search_box.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Search",
              ),
            ),
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
          Icon(Icons.person),
          SizedBox(
            width: width * .03,
          )
        ],
      ),
      body: FutureBuilder(
          future: getAllProductBySubId(widget.subCatId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data;

              return snapshot.data.status
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 1.3 / 2,
                                  crossAxisSpacing: 13,
                                  mainAxisSpacing: 16),
                          itemCount: data.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var item = data[index];

                            bool wishlist =
                                item.wishlist.toLowerCase() == 'true';

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewSingleProductPage(
                                              productId: item.productId,
                                              price: item.salePrice,
                                              vendorId: item.vendorId,
                                              subCatId: item.subCategory,
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
                                                  NetworkImage(item.imgUrl))),
                                    ),
                                    ListTile(
                                      dense: true,
                                      title: Text(
                                        item.title.toString().toUpperCase(),
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13),
                                        maxLines: 2,
                                      ),
                                      subtitle: Text(
                                        item.tag.toString().toUpperCase(),
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11),
                                        maxLines: 1,
                                      ),
                                      trailing: wishlist
                                          ? Icon(
                                              Icons.favorite,
                                              color: Color(0xffEA5524),
                                            )
                                          : Icon(Icons.favorite_border),
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: width * .05,
                                        ),
                                        Text(
                                          "${item.salesCurrency} ${item.salePrice}",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffEA5524),
                                              fontSize: 13),
                                        ),
                                        Text(
                                          "    ${item.discount}% OFF",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff0F9D58),
                                              fontSize: 9),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: width * .05,
                                              ),
                                              Image.asset(
                                                  "images/icon/rating.png", scale: 4,),
                                              SizedBox(
                                                width: width * .01,
                                              ),
                                              Text(
                                                item.ratingTotal,
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
                                        ),
                                        Expanded(child: Icon(Icons.more_horiz , size: 15,)),
                                      ],
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }),
                    )
                  : Center(child: Text("SomeThing went Wrong"));
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Loading();
            }
          }),
    );
  }
}
