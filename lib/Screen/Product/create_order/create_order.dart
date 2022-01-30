import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/add_address_model.dart';
import 'package:sell_beta_customer/Api/model/create_order_model.dart';
import 'package:sell_beta_customer/Api/model/payment_initiate_model.dart';
import 'package:sell_beta_customer/Api/model/verification_payment_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Orders/order_list.dart';
import 'package:sell_beta_customer/Screen/Product/create_order/list_address.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:sell_beta_customer/Screen/home.dart';

class CreateOrderPage extends StatefulWidget {
  final createOrderData;
  final addressId;
  final page;
  final price;

  const CreateOrderPage(
      {Key? key,
      this.addressId,
      this.page,
      this.createOrderData,
      this.price})
      : super(key: key);

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  var publicKey = 'pk_test_8ae701726ab13cd5e2423f4ba91ee23b984f0b98';
  final plugin = PaystackPlugin();
  CreateOrderModel _model = CreateOrderModel();
  var paymentType;
  var currentStep = 0;

  var newStateId;

  var newCityId;

  String? addressId;
  dynamic selectedAddress;

  var emailId;

  onlinePayment(user, email) async {
    print(widget.price.runtimeType);
    showToast("Payment Initialise");
    PaymentInitiateModel? model =
        await paymentInitiate("$email", "${widget.price}", "$user");
    if (model!.status == true) {
      dynamic lastCharge = widget.price;
      var i = lastCharge.toInt();
      print(i.runtimeType);
      Charge charge = Charge()
        ..amount = i * 100
        ..reference = "${model.data!.reference}"
        ..accessCode = "${model.data!.accessCode}"
        // or ..accessCode = _getAccessCodeFrmInitialization()
        ..email = '$email';
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        // Defaults to CheckoutMethod.selectable
        charge: charge,
      );
      if (response.status) {
        showToast("Verify Payment");
        VerificationPaymentModel? vModel =
            await verifyPayment(response.reference);
        if (vModel!.status == true) {
          showToast("Finalising Order");
          widget.createOrderData.addAll({
            'user_id': '$user',
            'address_id': '$addressId',
            'payment_status': 'paid',
            'payment_method': '$paymentType'
          });
          print(widget.createOrderData);
          CreateOrderModel? model = await createOrder(widget.createOrderData);
          if (model!.status == true) {
            setState(() {
              _model = model;
              currentStep = 2;
            });
            showToast(model.message);
          } else {
            showToast(model.message);
          }
        } else {
          showToast(vModel.message);
        }
      } else {
        showToast(response.message);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStep = widget.page ?? 0;
    plugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
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
      ),
      body: Stepper(
          elevation: 5,
          type: StepperType.horizontal,
          physics: ClampingScrollPhysics(),
          controlsBuilder: (context, control) {
            return Row(
              children: [
                currentStep == 0
                    ? Container()
                    : currentStep == 1
                        ? Expanded(
                            child: CustomButtons(
                              onPressed: () async {
                                if (paymentType == "COD") {
                                  widget.createOrderData.addAll({
                                    'user_id': '${user.userId}',
                                    'address_id':
                                        '$addressId',
                                    'payment_status': 'Unpaid',
                                    'payment_method': '$paymentType'
                                  });
                                  print(widget.createOrderData);
                                  CreateOrderModel? model =
                                      await createOrder(widget.createOrderData);
                                  if (model!.status == true) {
                                    setState(() {
                                      _model = model;
                                      currentStep = 2;
                                    });
                                    showToast(model.message);
                                  } else {
                                    showToast(model.message);
                                  }
                                } else {
                                  onlinePayment(user.userId.toString(), emailId);
                                }
                              },
                              color: [Color(0xffF15741), Color(0xffF29F46)],
                              text: "Payment",
                            ),
                          )
                        : Expanded(
                            child: CustomButtons(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>
                                Home()
                                ), (route) => false);
                              },
                              color: [Color(0xffF15741), Color(0xffF29F46)],
                              text: "Purchase More",
                            ),
                          )
              ],
            );
          },
          currentStep: currentStep,
          steps: [
            Step(
              state: StepState.editing,
              title: Text("Address"),
              content: FutureBuilder(
                  future: getAddressList(user.userId),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          TextButton.icon(
                              onPressed: () async {
                                bool data = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddressList()));
                                if (data) {
                                  setState(() {});
                                }
                              },
                              icon: Icon(Icons.add_location),
                              label: Text("Add Address")),
                          snapshot.data.status
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = snapshot.data.data[index];
                                    return Card(
                                      child: Column(
                                        children: [
                                          ListTile(
                                            onTap: () {

                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             CreateOrderPage(
                                              //                 addressId:
                                              //                     data.addressId,
                                              //                 createOrderData: widget
                                              //                     .createOrderData,
                                              //                 price: widget.price,
                                              //                 email: data.email,
                                              //                 page: 1)));
                                            },
                                            dense: true,
                                            title: Text("Shipping Address"),
                                            trailing: TextButton(onPressed: (){
                                              setState(() {
                                                currentStep = 1;
                                                emailId = data.email;
                                                addressId = data.addressId.toString();
                                                selectedAddress = data;
                                              });
                                            }, child: Text("Select"),),
                                          ),
                                          Divider(thickness: 2,),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 14),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5,),
                                                Text(data.fullName??""),SizedBox(height: 5,),
                                                Text(data.email??""),SizedBox(height: 5,),
                                                Text(data.mobileNo??""),SizedBox(height: 5,),
                                                Text(data.address??""),SizedBox(height: 5,),
                                                Text(data.stateName??""),SizedBox(height: 5,),
                                                Text(data.cityName??""),SizedBox(height: 5,),
                                                Text(data.zip??""),SizedBox(height: 5,),
                                              ],),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            Step(
                title: Text("Payment"),
                content: Column(
                  children: [
                    selectedAddress!=null?
                    Card(
                      child: Column(
                        children: [

                          ListTile(

                            onTap: () {

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             CreateOrderPage(
                              //                 addressId:
                              //                     data.addressId,
                              //                 createOrderData: widget
                              //                     .createOrderData,
                              //                 price: widget.price,
                              //                 email: data.email,
                              //                 page: 1)));
                            },
                            dense: true,
                            tileColor: Colors.grey.shade200,
                            title: Text("Shipping Address"),
                            // trailing: TextButton(onPressed: (){
                            //   setState(() {
                            //     currentStep = 1;
                            //     emailId = .email;
                            //     addressId = data.addressId.toString();
                            //     selectedAddress = data;
                            //   });
                            // }, child: Text("Select"),),
                          ),
                          Divider(thickness: 2,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text(selectedAddress.fullName??""),SizedBox(height: 5,),
                                  Text(selectedAddress.email??""),SizedBox(height: 5,),
                                  Text(selectedAddress.mobileNo??""),SizedBox(height: 5,),
                                  Text(selectedAddress.address??""),SizedBox(height: 5,),
                                  Text(selectedAddress.stateName??""),SizedBox(height: 5,),
                                  Text(selectedAddress.cityName??""),SizedBox(height: 5,),
                                  Text(selectedAddress.zip??""),SizedBox(height: 5,),
                                ],),
                            ),
                          )
                        ],
                      ),
                    ):Container(),
                    ListTile(
                      title: Text(
                        "Payment Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        trailing: Radio(
                            value: "COD",
                            groupValue: paymentType,
                            onChanged: (value) {
                              setState(() {
                                paymentType = value;
                              });
                            }),
                        title: Text("COD"),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        trailing: Radio(
                            value: "Online",
                            groupValue: paymentType,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                paymentType = value;
                              });
                            }),
                        title: Text("Online"),
                      ),
                    )
                  ],
                )),
            Step(
                title: Text("Summary"),
                content: Column(
                  children: [
                    Text("Order Placed"),
                    _model.status == true
                        ? Column(
                            children: [
                              Divider(),
                              ListTile(
                                dense: true,
                                leading: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                title: Text("Thank You for shopping with us"),
                                subtitle: Text(
                                    "Order Code : ${_model.data![0].orderCode}"),
                              ),
                              Divider(),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                itemCount: _model.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data = _model.data![index];
                                  return Column(
                                    children: [
                                      ListTile(
                                        dense: true,
                                        leading: Image.network(
                                            data.productDetail!.image ?? ""),
                                        title: Text(
                                            "${data.productDetail!.title} \nBrand Name : ${data.productDetail!.brandName}"),
                                        subtitle: Text(""
                                            "QTY : ${data.cartDetail!.quantity} , "
                                            "Size : ${data.cartDetail!.size} ,"
                                            " Color : ${data.cartDetail!.color}\n"
                                            "${data.productDetail!.salePriceCurrency} ${data.cartDetail!.price}"),
                                      ),
                                      Divider(),
                                    ],
                                  );
                                },
                              ),
                              ListTile(
                                title: Text("Delivery Address"),
                              ),
                              ListTile(
                                dense: true,
                                title: Text(
                                    '${_model.data![0].shippingDetail!.fullName}  ${_model.data![0].shippingDetail!.mobileNo}'),
                                subtitle: Text(
                                    "${_model.data![0].shippingDetail!.cityName}, ${_model.data![0].shippingDetail!.stateName} , "
                                    "${_model.data![0].shippingDetail!.zip}"),
                              ),
                              Divider(),
                              ListTile(
                                title: Text("Payment Method"),
                                subtitle:
                                    Text("${_model.data![0].paymentMethod}"),
                                trailing:
                                    Text("${_model.data![0].paymentStatus}"),
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    title: Text("Price Details"),
                                  ),
                                  ListTile(
                                    title: Text("Product Charges"),
                                    trailing: Text(
                                        "${_model.data![0].productDetail!.salePriceCurrency}"
                                        "${widget.price}"),
                                  )
                                ],
                              )
                            ],
                          )
                        : Container()
                  ],
                )),
          ]),
    );
  }
}
