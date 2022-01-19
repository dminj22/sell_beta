import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/get_sub_category_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Screen/Product/product_by_sub_id.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int selected = 0;

  var font1 = GoogleFonts.inter(fontWeight: FontWeight.w600 , color: Color(0xffEA5524) );
  var font2 = GoogleFonts.inter(fontWeight: FontWeight.w400 , color: Colors.black );

  var titleName = "Category";

  var categoryId;

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
        actions: [

        ],
      ),
      body: FutureBuilder(
          future: getCategories(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data;

              return ListView(
                children: [
                  Row(
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
                                      selected = index;
                                    titleName =   item.categoryName;
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
                                            child: Image.network(item.catImgUrl,
                                                color: selected == index
                                                    ? Color(0xffF07221)
                                                    : Colors.black,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                              return Text("404");
                                            })),
                                        Expanded(
                                            flex: 1,
                                            child: Text(item.categoryName , style: selected == index?font1:font2,)),
                                        Expanded(flex: 1, child: Container()),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                      Expanded(
                          flex: 3,
                          child: Container(
                            height: height,
                            color: Colors.white,
                            child: Column(
                              children: [
                                FutureBuilder(
                                    future: getSubCategory(categoryId),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        var data = snapshot.data.data;
                                        return snapshot.data.status?
                                          ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: data.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var item = data[index];
                                            return InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductPage(
                                                  subCatId: item.subCategoryId,
                                                )));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                                                    )
                                                  ),
                                                  child: ListTile(
                                                    title: Text(item.subCategoryName.toString().toUpperCase()),
                                                    trailing: SizedBox(
                                                        height: 30,
                                                        child: VerticalDivider(thickness: 2,)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },):Text("Not Found");
                                      } else if (snapshot.hasError) {
                                        return Icon(Icons.error_outline);
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    }),
                              ],
                            ),
                          )),
                    ],
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
}
