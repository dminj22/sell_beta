import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Config/theme.dart';

class ViewSingleOrderPage extends StatefulWidget {
  const ViewSingleOrderPage({Key? key}) : super(key: key);

  @override
  _ViewSingleOrderPageState createState() => _ViewSingleOrderPageState();
}

class _ViewSingleOrderPageState extends State<ViewSingleOrderPage> {
  var current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
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
          future: singleOrderDetails(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data.data;
              DateTime date = data[0].orderDate;
              return snapshot.data.status?
                ListView(
                children: [
                  OrderTile(
                    title: "Order #${data[0].orderCode}",
                    trailing: TextButton(
                      child: Text(
                        "copy",
                        style: TextStyle(color: Color(primaryColor)),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  OrderTile(
                    title: "Customer Name",
                    trailing: Text("${data[0].userDetails.name}"),
                  ),
                  OrderTile(
                    title: "Payment Mode",
                    trailing: Text("${data[0].paymentMethod}"),
                  ),
                  Divider(),
                  Card(
                    child: Column(
                      children: [
                        OrderTile(
                          title: "Product Details",
                        ),
                        OrderTile(
                          leading: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(
                                          data[0].productList[0].image))),
                            ),
                          ),
                          title:
                              "${data[0].productList[0].title}".toUpperCase(),
                          subTitle: Text(
                              "Price  ${data[0].productList[0].salePriceCurrency}${data[0].totalAmount}\nSize    S\nQty        ${data[0].noOfProduct}"),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Stepper(
                        physics: ClampingScrollPhysics(),
                        currentStep: current,
                        onStepTapped: (value) {
                          setState(() {
                            current = value;
                          });
                        },
                        steps: [
                          Step(
                              state: StepState.complete,
                              isActive: true,
                              subtitle: Text("Successfully Order Placed"),
                              title: Text("Order Placed"),
                              content: Column(
                                children: [
                                  Text("Your Order has been Placed"),
                                  Text("${date.hour}:${date.minute}, ${date.day}/${date.month}/${date.year}"),
                                ],
                              )),
                          Step(
                              title: Text("Shipped"),
                              subtitle: Text("Expected by 01 January 2020"),
                              content: Column(
                                children: [
                                  Text("Your Order has been Placed"),
                                  Text("6:18 PM , 29 December, 2021"),
                                ],
                              )),
                          Step(
                              title: Text("Delivered"),
                              content: Column(
                                children: [
                                  Text("Your Order has been Placed"),
                                  Text("6:18 PM , 29 December, 2021"),
                                ],
                              )),
                        ]),
                  ),
                  Card(
                    child: Column(
                      children: [
                        OrderTile(
                          title: "Order Details",
                        ),
                        OrderTile(title: "Price BreakUp"),
                        OrderTile(
                          title: "Product Price",
                          trailing: Text("${data[0].totalAmount}"),
                        ),
                        OrderTile(
                          title: "Shipping Charges",
                          trailing: Text("${data[0].shippingCharge}"),
                        ),
                        OrderTile(
                          title: "COD Charges",
                          trailing: Text("362"),
                        ),
                        OrderTile(
                          title: "1st Order Discount",
                          trailing: Text("362"),
                        ),
                        Divider(),
                        OrderTile(
                          title: "Order Total",
                          trailing: Text("${data[0].totalAmount}"),
                        ),
                        OrderTile(
                          title: "Final Price",
                          trailing: Text("${data[0].totalAmount}"),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OrderTile(
                        title: "Shipping Address",
                        subTitle: Text(
                            "Customer Name : ${data[0].shippingAddress.fullName}\n${data[0].shippingAddress.address} , ${data[0].shippingAddress.area}, ${data[0].shippingAddress.cityName} , \n${data[0].shippingAddress.stateName} - ${data[0].shippingAddress.zip}\n${data[0].shippingAddress.email}   ,Phone No : ${data[0].shippingAddress.mobileNo}"),
                      ),
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        OrderTile(
                          title: "Sender Name",
                          trailing: Text("${data[0].vendorDetails.name}"),
                        ),
                        OrderTile(
                          title: "Sender Number",
                          trailing:
                              Text("Pincode : ${data[0].vendorDetails.zip}"),
                          subTitle: Text(
                              "${data[0].vendorDetails.address},${data[0].vendorDetails.city},${data[0].vendorDetails.state}"),
                        ),
                      ],
                    ),
                  )
                ],
              ) : Center(child: Text("Not Found"));
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}

class OrderTile extends StatelessWidget {
  final title;

  final trailing;

  final subTitle;

  final leading;

  const OrderTile(
      {Key? key, this.title, this.trailing, this.subTitle, this.leading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: leading,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: subTitle,
      trailing: trailing,
    );
  }
}
