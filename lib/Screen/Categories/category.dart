import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Screen/Product/product_by_sub_id.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int selected = 0;

  var font1 =
      GoogleFonts.inter(fontWeight: FontWeight.w600, color: Color(0xffEA5524));
  var font2 =
      GoogleFonts.inter(fontWeight: FontWeight.w400, color: Colors.black);

  var titleName = "Category";

  var categoryId;

  bool start = true;
  final scrollDirection = Axis.vertical;
  late AutoScrollController controller;

  Future jump(index) {
    setState(() {
      index = index;
    });
    return _scrollToCounter(index);
  }

  Future _scrollToCounter(index) async {
    await controller.scrollToIndex(index,
        duration: Duration(seconds: 1),
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(index);
  }

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(titleName),
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
        actions: [],
      ),
      body: FutureBuilder(
          future: getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data.data;
              if (start) {
                categoryId = data[0].categoryId.toString();
              }

              return Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              height: height,
                              color: Color(0xffEFEFEF),
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var item = data[index];

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        jump(int.parse(item.categoryId));
                                        selected = index;
                                        print(selected);
                                        titleName = item.categoryName;
                                        categoryId = item.categoryId;
                                      });
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 86,
                                      color: selected == index
                                          ? Colors.white
                                          : Color(0xffEFEFEF),
                                      child: Column(
                                        children: [
                                          Expanded(flex: 1, child: Container()),
                                          Expanded(
                                              flex: 2,
                                              child: Image.network(
                                                  item.catImgUrl,
                                                  color: selected == index
                                                      ? Color(0xffF07221)
                                                      : Colors.black,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                return Text("404");
                                              })),
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                item.categoryName,
                                                style: selected == index
                                                    ? font1
                                                    : font2,
                                              )),
                                          Expanded(flex: 1, child: Container()),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              child: ListView(
                                  scrollDirection: scrollDirection,
                                  controller: controller,
                                  shrinkWrap: true,
                                  children: data
                                      .map<Widget>((cat) => Container(
                                            child: _wrapScrollTag(
                                                index:
                                                    int.parse(cat.categoryId),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            cat.categoryName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Divider())
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    cat.subcategoryList
                                                            .isNotEmpty
                                                        ? GridView.count(
                                                            crossAxisSpacing:
                                                                10,
                                                            shrinkWrap: true,
                                                            physics:
                                                                ClampingScrollPhysics(),
                                                            crossAxisCount: 2,
                                                            children: cat
                                                                .subcategoryList
                                                                .map<Widget>(
                                                                    (subCat) =>
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => ProductPage(
                                                                                          subCatId: subCat.subCategoryId,
                                                                                        )));
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Expanded(child: CustomImage(url: subCat.subCatImgUrl,)),
                                                                                // Expanded(
                                                                                //     flex: 3,
                                                                                //     child: Container(
                                                                                //       decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: NetworkImage(subCat.subCatImgUrl))),
                                                                                //     )),
                                                                                Expanded(
                                                                                    child: Center(
                                                                                        child: Text(
                                                                                  '${subCat.subCategoryName}',
                                                                                  style: TextStyle(fontWeight: FontWeight.w600),
                                                                                )))
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ))
                                                                .toList(),
                                                          )
                                                        : Text("No Product")
                                                  ],
                                                )),
                                          ))
                                      .toList()),
                            ))
                      ],
                    ),
                  )
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

  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
}
