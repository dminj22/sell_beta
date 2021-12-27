import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return ListView(
      children: [
        ExpandedTile(
            title: Text("All Products"),
            content: Column(
              children: [
                Wrap(
                  children: item
                      .map<Widget>((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffFFDDD8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
            controller: controller),
        ExpandedTile(
            title: Text("Atasan wanita"),
            content: Column(
              children: [
                Wrap(
                  children: item
                      .map<Widget>((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Color(0xffFFDDD8),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
            controller: controller),
      ],
    );
  }
}
