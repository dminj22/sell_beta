import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Orders/view_single_order.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  var type = [
    "All", "Ordered" , "Shipped" , "Delivered" , "Cancelled" , "Exchanged" , "Return" , "Others"
  ];
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Order'),
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
      body: Column(
        children: [
          ListTile(title: Text("Your Orders"),),
          Wrap(children: type.map<Widget>((e) => InkWell(
              onTap: (){},
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Chip(label: Text(e)),
              ))).toList(),),

          Expanded(
            child: FutureBuilder(
                future: customerOrderList(user.userId),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data.data;

                    return snapshot.data.status
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              DateTime date = data[index].orderDate;
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 5,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewSingleOrderPage()));
                                    },
                                    // leading: Card(
                                    //   elevation: 0,
                                    //   color: Colors.transparent,
                                    //   child: Container(
                                    //     width: 60,
                                    //     height: 100,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.all(Radius.circular(10)),
                                    //         image: DecorationImage(
                                    //             fit: BoxFit.cover,
                                    //             image: NetworkImage(data[index]
                                    //                 .productList[0]
                                    //                 .image))),
                                    //   ),
                                    // ),
                                    title:
                                        Text("${data[index].productList[0].title}"),
                                    trailing: Icon(Icons.arrow_forward_ios),
                                    subtitle: Wrap(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.green,
                                            radius: 5,
                                          ),
                                        ),
                                        Text(
                                            "Order on : ${date.day}-${date.month}-${date.year}\nPayment Type : ${data[index].paymentMethod}" , style: GoogleFonts.inter(fontSize: 10),),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : Center(child: Text("No Order Placed"));
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ],
      ),
    );
  }
}
