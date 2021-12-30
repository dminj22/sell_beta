import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Screen/Orders/view_single_order.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({Key? key}) : super(key: key);

  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  @override
  Widget build(BuildContext context) {
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
        actions: [

        ],
      ),
      body: FutureBuilder(
          future: customerOrderList(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data =snapshot.data.data;

              return snapshot.data.status?
              ListView.builder(itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewSingleOrderPage()));
                    },
                    leading: CircleAvatar(),
                    title: Text("${data[index].username}"),
                    subtitle: Text("${data[index].addressId}"),
                    trailing: Text("${data[index].totalAmount}"),
                  );
                },): Center(child: Text("No Order Placed"));
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Loading();
            }
          }),
    );
  }
}
