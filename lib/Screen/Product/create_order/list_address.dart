import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Product/create_order/create_order.dart';

class AddressList extends StatefulWidget {
  final createOrderData;
  const AddressList({Key? key, this.createOrderData}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
      ),
      body: FutureBuilder(
          future: getAddressList(user.userId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.status
                  ? ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data.data[index];
                        return Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateOrderPage(
                                          addressId: data.addressId,createOrderData: widget.createOrderData,
                                          page: 1)));
                            },
                            dense: true,
                            title: Text("Name : ${data.fullName}"),
                            subtitle: Text(
                                "${data.email} - ${data.mobileNo}\n${data.address}"),
                          ),
                        );
                      },
                    )
                  : Text("No address Add New");
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
