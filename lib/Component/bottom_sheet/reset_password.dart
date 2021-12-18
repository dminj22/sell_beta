import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';

class ResetPassSheet extends StatefulWidget {


  const ResetPassSheet({Key? key, this.onPressed, this.pass1, this.pass2}) : super(key: key);
  final onPressed;
  final pass1;
  final pass2;

  @override
  State<ResetPassSheet> createState() => _ResetPassSheetState();
}

class _ResetPassSheetState extends State<ResetPassSheet> {

  @override
  Widget build(BuildContext context) {
    var passObscure = true;
    var passObscure1 = true;

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var font1 = GoogleFonts.inter(
        fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white);
    var font2 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
    var font3 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
    var font4 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);
    var font5 = GoogleFonts.inter(
        fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black);
    var font6 = GoogleFonts.inter(
        fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xff979797));
    return WillPopScope(
      onWillPop: ()async{
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Are you sure you want to abort this process?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes, exit'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            }
        );

        return value == true;
      },
      child: Padding(
        padding: mediaQueryData.viewInsets,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              height: height * .5,
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110, vertical: 10),
                      child: Divider(
                        color: Colors.grey,
                        thickness: 4,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * .01,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Reset Password",
                            style: font5,
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          """Set the new password for your account so
you can login and access all tha features.""",
                          style: font6,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    StatefulBuilder(
                      builder: (BuildContext context ,void Function(void Function()) setState){
                        return Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Password",
                                  style: font3,
                                ),
                              ),
                              CustomTextField(
                                controller: widget.pass1,
                                obscure: passObscure,
                                hint: "**** **** ****",
                                icon: Icons.remove_red_eye_outlined,
                                check: passObscure,
                                iconColor: passObscure
                                    ? Colors.black
                                    : Color(0xffF15741),
                                onPressed: () {
                                  setState(() {
                                    passObscure = !passObscure;
                                    print(passObscure);
                                  });
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Confirm Password",
                                  style: font3,
                                ),
                              ),
                              CustomTextField(
                                controller: widget.pass2,
                                obscure: passObscure1,
                                hint: "**** **** ****",
                                icon: Icons.remove_red_eye_outlined,
                                check: passObscure1,
                                iconColor: passObscure1
                                    ? Colors.black
                                    : Color(0xffF15741),
                                onPressed: () {
                                  setState(() {
                                    passObscure1 = !passObscure1;
                                    print(passObscure1);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    CustomButtons(
                        color: [Color(0xffF15741), Color(0xffF29F46)],
                        text: "Reset Password",
                        onPressed: widget.onPressed),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 110, vertical: 10),
                      child: Divider(
                        color: Colors.black,
                        thickness: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
