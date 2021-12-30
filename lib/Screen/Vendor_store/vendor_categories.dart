import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';

class VendorCategories extends StatefulWidget {
  const VendorCategories({Key? key}) : super(key: key);

  @override
  _VendorCategoriesState createState() => _VendorCategoriesState();
}

class _VendorCategoriesState extends State<VendorCategories> {
  var controller = ExpandedTileController();
  dynamic item = [
    {"i": "item1"},
    {"i": "item2"},
    {"i": "item2"},
    {"i": "item3"},
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCatSubCat(4),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.status?
              ListView.builder(
              itemCount: snapshot.data.data[0].categoryList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data.data[0];
                return ExpandedTile(
                    title: Text("${data.categoryList[index].categoryName}"),
                    content: Column(
                      children: [
                        Wrap(
                          children: item
                              .map<Widget>((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Color(0xffFFDDD8),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${e["i"]}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                                color: Color(primaryColor)),
                                          ),
                                        )),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                    controller: controller);
              },
            ):Text("No Categories");
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
