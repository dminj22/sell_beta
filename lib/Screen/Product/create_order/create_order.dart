import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Screen/Profile/profile_edit.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  _CreateOrderPageState createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
          controlsBuilder: (context , control){
          return Row(children: [
            index == 0?
            Expanded(
              child: CustomButtons(
                onPressed: (){
                  setState(() {
                    index = index +1;
                  });
                },
                color: [
                  Color(0xffF15741),
                  Color(0xffF29F46)
                ],
                text: "Save Address and Continue",
              ),
            ):Expanded(
              child: CustomButtons(
                onPressed: (){
                  setState(() {
                    index = index +1;
                  });
                },
                color: [
                  Color(0xffF15741),
                  Color(0xffF29F46)
                ],
                text: "Payment",
              ),
            )
          ],);
          },
          currentStep: index,
          steps: [
            Step(
              state: StepState.editing,
              title: Text("Address"),
              content: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: CustomTextField(
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
                        label: Text("Pin Code"),
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
                        label: Text("City"),
                      )),
                      SizedBox(
                        width: width * .01,
                      ),
                      Expanded(
                          child: CustomTextField(
                        label: Text("State"),
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
                        label: Text("Pin Code"),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                ],
              ),
            ),
            Step(
                title: Text("Payment"),
                content: Column(
                  children: [],
                )),
            Step(
                title: Text("Summary"),
                content: Column(
                  children: [],
                )),
          ]),
    );
  }
}
