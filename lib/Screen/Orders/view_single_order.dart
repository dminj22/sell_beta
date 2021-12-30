import 'package:flutter/material.dart';
import 'package:sell_beta_customer/Config/theme.dart';

class ViewSingleOrderPage extends StatefulWidget {
  const ViewSingleOrderPage({Key? key}) : super(key: key);

  @override
  _ViewSingleOrderPageState createState() => _ViewSingleOrderPageState();
}

class _ViewSingleOrderPageState extends State<ViewSingleOrderPage> {
  var current = 0 ;

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
            title: "Order #123456",
            trailing: TextButton(child: Text("copy", style: TextStyle(color: Color(primaryColor)),), onPressed: (){

            },),
          ),
          OrderTile(title: "Customer Name", trailing: Text("yash"),),
          OrderTile(title: "Payment Mode", trailing: Text("Cash On Delivery"),),
          Divider(),
          Card(child: Column(children: [
            OrderTile(title: "Product Details",),
            OrderTile(
              leading: CircleAvatar(),
              title: "Men's Navy Blue Printed cotton Short Sleeve Rounded Neck T-Shirt",
              subTitle: Text("Price  362\nSize    S\nQty        1"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            SizedBox(height: 30,),
          ],),),
          Card(child: Stepper(
            physics: ClampingScrollPhysics(),
            currentStep: current,
              onStepTapped: (value){
              setState(() {
                current = value;
              });
              },
              steps: [
            Step(
                state: StepState.complete,
                isActive: true,
                subtitle: Text("Successfully Order Placed"),
                title: Text("Order Placed"), content: Column(
              children: [
                Text("Your Order has been Placed"),
                Text("6:18 PM , 29 December, 2021"),
              ],
            )),
            Step(title: Text("Shipped"), subtitle: Text("Expected by 01 January 2020"),content: Column(
              children: [
                Text("Your Order has been Placed"),
                Text("6:18 PM , 29 December, 2021"),
              ],
            )),
            Step(

                title: Text("Delivered"), content: Column(
              children: [
                Text("Your Order has been Placed"),
                Text("6:18 PM , 29 December, 2021"),
              ],
            )),
          ]),),
          Card(child: Column(children: [
            OrderTile(title: "Order Details",),
            OrderTile(title: "Price BreakUp"),
            OrderTile(title: "Product Price" , trailing: Text("362"),),
            OrderTile(title: "Shipping Charges" , trailing: Text("362"),),
            OrderTile(title: "COD Charges" , trailing: Text("362"),),
            OrderTile(title: "1st Order Discount" , trailing: Text("362"),),
            Divider(),
            OrderTile(title: "Order Total" , trailing: Text("362"),),
            OrderTile(title: "Final Price" , trailing: Text("362"),),

          ],),),
          Card(child: OrderTile(title: "Shipping Address", subTitle: Text("Address of Users"),),),
          Card(child: Column(
            children: [
              OrderTile(title: "Sender Name", trailing: Text("Address of Users"),),
              OrderTile(title: "Sender Number", trailing: Text("Address of Users"),),
            ],
          ),)
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

  const OrderTile({Key? key, this.title, this.trailing, this.subTitle, this.leading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: leading,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w700),),
      subtitle: subTitle,
      trailing: trailing,
    );
  }
}
