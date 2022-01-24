import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feeds'),
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
          future: getFeeds(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return snapshot.data.status
                  ? ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Feeds(
                          data: snapshot.data.data[index],
                        );
                      },
                    )
                  : Text("Error");
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

class Feeds extends StatefulWidget {
  final data;

  const Feeds({Key? key, this.data}) : super(key: key);

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.data.vendorDetails.image ?? ""),
            ),
            title: Text(widget.data.vendorDetails.name ?? ""),
            subtitle: Row(
              children: [
                SizedBox(
                    height: h * .03,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xffFFD4CE)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                      ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.store,
                          color: Color(0xffF15741),
                          size: 12,
                        ),
                        label: Text(
                          "Store",
                          style: TextStyle(fontSize: 8 , color: Color(0xffF15741)),
                        ))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("771 Followers" , style: TextStyle(fontSize: 10 , fontWeight: FontWeight.bold),),
                )
              ],
            ),
            trailing: SizedBox(
              height: h * .05,
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      //background color of box
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 25.0, // b
                        spreadRadius: 5.0, //0
                        offset: Offset(
                          15.0, // x
                          15.0, // y
                        ),
                      )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xffF15741), Color(0xffF29F46)]),
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      elevation: MaterialStateProperty.all(0)),
                  onPressed: () async {},
                  child: Text("Follow"),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(widget.data.image[0].url??""),
          )
        ],
      ),
    );
  }
}
