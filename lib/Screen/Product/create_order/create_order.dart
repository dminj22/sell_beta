import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/add_address_model.dart';
import 'package:sell_beta_customer/Api/model/create_order_model.dart';
import 'package:sell_beta_customer/Api/model/payment_initiate_model.dart';
import 'package:sell_beta_customer/Api/model/verification_payment_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';
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
      {Key? key, this.addressId, this.page, this.createOrderData, this.price})
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
  var addressRadio;

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
        fullscreen: true,
        method: CheckoutMethod.selectable,
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
              log(model.toString());
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

  Future<void> _showMyDialog(noOfDel, onPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          title: const Text('Confirm to delete?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete?'),
              ],
            ),
          ),
          actions: <Widget>[
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Color(primaryColor)),
                  ),
                )),
            SizedBox(
              width: 100,
              child: CustomButtons(
                onPressed: onPressed,
                color: [Color(0xffF15741), Color(0xffF29F46)],
                text: "Delete",
              ),
            )
          ],
        );
      },
    );
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
          elevation: 4,
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
                                    'address_id': '$addressId',
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
                                  onlinePayment(
                                      user.userId.toString(), emailId);
                                }
                              },
                              color: [Color(0xffF15741), Color(0xffF29F46)],
                              text: "Payment",
                            ),
                          )
                        : Expanded(
                            child: CustomButtons(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (route) => false);
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
              state: currentStep == 0 ? StepState.editing : StepState.complete,
              isActive: currentStep == 0 ? true : false,
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
                              icon: Icon(
                                Icons.add_location,
                                color: Color(primaryColor),
                              ),
                              label: Text(
                                "Add Address",
                                style: TextStyle(color: Color(primaryColor)),
                              )),
                          snapshot.data.status
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemCount: snapshot.data.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data = snapshot.data.data[index];
                                    return Card(
                                      elevation: selectedAddress ==
                                              data.addressId.toString()
                                          ? 4
                                          : 2,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            dense: true,
                                            title: Text(data.fullName ?? ""),
                                            trailing: Radio(
                                                value:
                                                    data.addressId.toString(),
                                                groupValue: addressRadio,
                                                onChanged: (value) {
                                                  setState(() {
                                                    addressRadio = value;
                                                  });
                                                }),
                                          ),
                                          Divider(
                                            height: 5,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 14, top: 10),
                                              child: Wrap(
                                                children: [
                                                  Text("${data.email} , "),
                                                  Text("${data.address} , "),
                                                  Text("${data.stateName} , "),
                                                  Text("${data.cityName} , "),
                                                  Text("${data.zip} , "),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 14,
                                                    top: 15,
                                                    bottom: 10),
                                                child: Text("${data.mobileNo}"),
                                              ),
                                              addressRadio ==
                                                      data.addressId.toString()
                                                  ? IconButton(
                                                      onPressed: () {
                                                        _showMyDialog(
                                                            "noOfDel", () {});
                                                      },
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ))
                                                  : Container()
                                            ],
                                          ),
                                          addressRadio ==
                                                  data.addressId.toString()
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                                  child: CustomButtons(
                                                    onPressed: () {
                                                      setState(() {
                                                        currentStep = 1;
                                                        emailId = data.email;
                                                        addressId = data
                                                            .addressId
                                                            .toString();
                                                        selectedAddress = data;
                                                      });
                                                    },
                                                    color: [
                                                      Color(0xffF15741),
                                                      Color(0xffF29F46)
                                                    ],
                                                    text:
                                                        "Deliver to this Address",
                                                  ),
                                                )
                                              : Container()
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
                      return Loading();
                    }
                  }),
            ),
            Step(
                state:
                    currentStep == 1 ? StepState.editing : StepState.complete,
                isActive: currentStep == 1 ? true : false,
                title: Text("Payment"),
                content: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Payment Type",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.delivery_dining),
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
                        leading: Image.asset(
                          "images/payment logo.png",
                          height: 20,
                        ),
                        title: Text("Paystack"),
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    selectedAddress != null
                        ? Card(
                            child: Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  tileColor: Colors.grey.shade200,
                                  title: Text("Shipping Address"),
                                  trailing: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        currentStep = 0;
                                      });
                                    },
                                    child: Text(
                                      "change",
                                      style:
                                          TextStyle(color: Color(primaryColor)),
                                    ),
                                  ),
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(selectedAddress.fullName ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedAddress.email ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedAddress.mobileNo ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedAddress.address ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedAddress.stateName ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedAddress.cityName ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(selectedAddress.zip ?? ""),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Card(child: ListTile(title: Text("Price Details"))),
                    ListTile(
                      dense: true,
                      title: Text("Total Price"),
                      trailing: Text(widget.price.toString()),
                    )
                  ],
                )),
            Step(
                state:
                    currentStep == 2 ? StepState.editing : StepState.complete,
                isActive: currentStep == 2 ? true : false,
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
                              Card(
                                  child: Column(
                                children: [
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
                                ],
                              )),
                              Divider(),
                              Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Seller Details"),
                                    ),
                                    ListTile(
                                      leading: Container(
                                          width: 50,
                                          height: 50,
                                          child: CustomImage(
                                            url: _model
                                                .data![0].vendorDetail!.image,
                                          )),
                                      title: Text("Seller Name"),
                                      trailing: Text(
                                          "${_model.data![0].vendorDetail!.name}"),
                                    ),
                                    ListTile(
                                      title: Text("Address"),
                                      subtitle: Text(
                                          "${_model.data![0].vendorDetail!.address} ,${_model.data![0].vendorDetail!.state} , ${_model.data![0].vendorDetail!.zip}"),
                                    ),
                                  ],
                                ),
                              ),
                              Card(
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text("Payment Method"),
                                      subtitle: Text(
                                          "${_model.data![0].paymentMethod}"),
                                      trailing: Text(
                                          "${_model.data![0].paymentStatus}"),
                                    ),
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
                                ),
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
