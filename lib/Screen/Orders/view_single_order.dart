import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Config/theme.dart';

class ViewSingleOrderPage extends StatefulWidget {
  final orderId;
  final singleData;
  const ViewSingleOrderPage({Key? key, this.orderId, this.singleData}) : super(key: key);

  @override
  _ViewSingleOrderPageState createState() => _ViewSingleOrderPageState();
}

class _ViewSingleOrderPageState extends State<ViewSingleOrderPage> {
  var current = 0;
  var data;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = widget.singleData;
  }

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
      body: ListView(
        children: [
          OrderTile(
            title: "Order #${data.orderCode??""}",
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
            trailing: Text("${data.userDetail.name??""}"),
          ),
          OrderTile(
            title: "Payment Mode",
            trailing: Text("${data.paymentMethod??""}"),
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
                                  data.productDetail.image??""))),
                    ),
                  ),
                  title:
                  "${data.productDetail.title??""}".toUpperCase(),
                  subTitle: Text(
                      "Price  ${data.productDetail.salePriceCurrency??""}${data.cartDetail.price??""}\nSize    S\nQty        ${data.cartDetail.quantity??""}"),
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
                          Text("${data.orderTime??""} - ${data.orderDate??""}"),
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
                  trailing: Text("${data.productDetail.salePriceCurrency??""} ${data.cartDetail.price??""}"),
                ),
                OrderTile(
                  title: "Shipping Charges",
                  trailing: Text("${data.productDetail.salePriceCurrency??""} 0"),
                ),
                OrderTile(
                  title: "COD Charges",
                  trailing: Text("${data.productDetail.salePriceCurrency??""} 0"),
                ),
                OrderTile(
                  title: "1st Order Discount",
                  trailing: Text("${data.productDetail.salePriceCurrency??""} 0"),
                ),
                Divider(),
                OrderTile(
                  title: "Order Total",
                  trailing: Text("${data.productDetail.salePriceCurrency??""} ${data.cartDetail.price??""}"),
                ),
                OrderTile(
                  title: "Final Price",
                  trailing: Text("${data.productDetail.salePriceCurrency??""} ${data.cartDetail.price??""}"),
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
                    "Customer Name : ${data.shippingDetail.fullName??""}\n${data.shippingDetail.address??""} , ${data.shippingDetail.area??""}, ${data.shippingDetail.cityName??""} , \n${data.shippingDetail.stateName??""} - ${data.shippingDetail.zip??""}\n${data.shippingDetail.email??""}   ,Phone No : ${data.shippingDetail.mobileNo??""}"),
              ),
            ),
          ),
          Card(
            child: Column(
              children: [
                OrderTile(
                  title: "Sender Name",
                  trailing: Text("${data.vendorDetail.name??""}"),
                ),
                OrderTile(
                  title: "Sender Number",
                  trailing:
                  Text("Pincode : ${data.vendorDetail.zip??""}"),
                  subTitle: Text(
                      "${data.vendorDetail.address??""},${data.vendorDetail.city??""},${data.vendorDetail.state??""}"),
                ),
              ],
            ),
          )
        ],
      ),
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
