import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';

class VendorFollowerList extends StatelessWidget {
  final vendorId;
  const VendorFollowerList({Key? key, this.vendorId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Follower"),
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
          future: getFollowerList(vendorId),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data;
              return snapshot.data.status?
                ListView.builder(itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("${data[index].profilePhotoUrl}"),
                    ),
                    title: Text("${data[index].username}"),
                    subtitle: Text('${data[index].stateName}'),
                  );
                },): Text("No Follower");
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Loading();
            }
          }),
    );
  }
}
