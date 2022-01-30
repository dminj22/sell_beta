import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/add_address_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:sell_beta_customer/Screen/Product/create_order/create_order.dart';

class AddressList extends StatefulWidget {
  final createOrderData;
  const AddressList({Key? key, this.createOrderData}) : super(key: key);

  @override
  _AddressListState createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  var newStateId;

  var newCityId;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var houseController = TextEditingController();
  var areaController = TextEditingController();
  var pinController = TextEditingController();

  int? addressId;

  int? index;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Color(0xffEA5524),
                    Color(0xffF7941D),
                  ])),),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    controller: nameController,
                    label: Text("Name"),
                  )),
            ],
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    keyboard: TextInputType.number,
                    controller: phoneController,
                    label: Text("Phone Number"),
                  )),
            ],
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    controller: emailController,
                    label: Text("Email"),
                  )),
            ],
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    controller: houseController,
                    label: Text("House no./ Building Name"),
                  )),
            ],
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    controller: areaController,
                    label: Text("Road Name/Area/Colony"),
                  )),
            ],
          ),
          SizedBox(
            height: height * .01,
          ),
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                    keyboard: TextInputType.number,
                    controller: pinController,
                    label: Text("Pin Code"),
                  )),
            ],
          ),
          SizedBox(
            height: height * .03,
          ),
          FutureBuilder(
              future: getStateList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data.data;
                  List stateName =
                  data.map((e) => e.stateName).toList();
                  List stateId = data.map((e) => e.stateId).toList();
                  print(stateId);
                  return SizedBox(
                    height: 45,
                    child: DropdownSearch<dynamic>(
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        items:
                        data.map((e) => "${e.stateName}").toList(),
                        label: "State",
                        hint: "Select",
                        popupItemDisabled: (dynamic s) =>
                            s.startsWith('I'),
                        onChanged: (value) {
                          setState(() {
                            newStateId =
                            stateId[stateName.indexOf(value)];
                          });
                        },
                        selectedItem: "Select State"),
                  );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
          SizedBox(
            height: height * .03,
          ),
          newStateId != null
              ? FutureBuilder(
              future: getCityList(newStateId),
              builder:
                  (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List data = snapshot.data.data;
                  List cityName =
                  data.map((e) => e.cityName).toList();
                  List cityId = data.map((e) => e.cityId).toList();
                  return SizedBox(
                    height: 45,
                    child: DropdownSearch<dynamic>(
                        showSearchBox: true,
                        mode: Mode.BOTTOM_SHEET,
                        items: data.asMap().entries.map((e) {
                          return "${e.value.cityName}";
                        }).toList(),
                        label: "City",
                        hint: "Select",
                        popupItemDisabled: (dynamic s) =>
                            s.startsWith('I'),
                        onChanged: (value) {
                          newCityId =
                          cityId[cityName.indexOf(value)];
                        },
                        selectedItem: "Select City"),
                  );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              })
              : Container(),
          SizedBox(
            height: height * .03,
          ),
          CustomButtons(
            onPressed: () async {
              try {
                if (nameController.text.isNotEmpty &&
                    emailController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty &&
                    houseController.text.isNotEmpty &&
                    areaController.text.isNotEmpty &&
                    pinController.text.isNotEmpty &&
                    newStateId != null &&
                    newCityId != null) {
                  var userId = "${user.userId}";
                  var name = nameController.text;
                  var email = emailController.text;
                  var number = phoneController.text;
                  var address = houseController.text;
                  var stateId = newStateId;
                  var cityId = newCityId;
                  var area = areaController.text;
                  var zip = pinController.text;
                  AddAddressModel? model = await addAddress(
                      userId,
                      name,
                      email,
                      number,
                      address,
                      stateId,
                      cityId,
                      area,
                      zip);
                  if (model!.status == true) {
                    setState(() {
                      Navigator.pop(context , true);
                      showToast(model.message);
                    });
                  } else {
                    showToast(model.message);
                  }
                } else {
                  showToast("Fill All Details");
                }
              } catch (e) {
                showToast(e);
              }
            },
            color: [Color(0xffF15741), Color(0xffF29F46)],
            text: "Save Address and Continue",
          )
        ],
      ),
    );
  }
}
