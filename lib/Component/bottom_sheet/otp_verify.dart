import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/forget_password_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpModalSheet extends StatefulWidget {
  const OtpModalSheet({Key? key, this.onPressed, this.email}) : super(key: key);
  final onPressed;
  final email;

  @override
  State<OtpModalSheet> createState() => _OtpModalSheetState();
}

class _OtpModalSheetState extends State<OtpModalSheet> {
  bool showResend = false;

  resendOtp() async {
    try {
      ForgetPasswordModel? model = await forgetPassword(widget.email);
      if (model!.status) {
        showToast("${model.message}");
        setState(() {
          showResend = false;
        });
      } else {
        showToast("${model.message}");
      }
    } catch (e) {
      showToast(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    var user = Provider.of<UserProvider>(context);
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
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff979797));
    var buttonColor = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xffF15741));
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            "Enter 4 Digits Code",
                            style: font5,
                          ),
                        ),
                        SizedBox(
                          height: height * .01,
                        ),
                        Text(
                          """Don't worrry! just fil in your email and we'll send
you a link to reset your password.""",
                          style: font6,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * .04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: PinCodeTextField(
                            keyboardType: TextInputType.number,
                            length: 4,
                            obscureText: false,
                            cursorColor: Color(0xffEFEFEF),
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              inactiveFillColor: Color(0xffEFEFEF),
                              inactiveColor: Colors.black,
                              selectedFillColor: Color(0xffEFEFEF),
                              selectedColor: Color(0xffF15741),
                              activeColor: Colors.black,
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 40,
                              fieldWidth: 40,
                              activeFillColor: Color(0xffEFEFEF),
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            onCompleted: (v) {
                              print(v);
                            },
                            onChanged: (value) {
                              user.otp = value;
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                            appContext: context,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't receive OTP?",
                          style: font3,
                        ),
                        showResend
                            ? Container(
                                child: TextButton(
                                  onPressed: () async {
                                    resendOtp();
                                  },
                                  child: Text("Resend Otp"),
                                ),
                              )
                            : TextButton(
                                onPressed: () {},
                                child: Row(
                                  children: [
                                    Text(
                                      "Resend after",
                                      style: buttonColor,
                                    ),
                                    Countdown(
                                      seconds: 128,
                                      build:
                                          (BuildContext context, double time) =>
                                              Text(
                                        " ${time.toInt().toString()} sec",
                                        style: buttonColor,
                                      ),
                                      interval: Duration(seconds: 1),
                                      onFinished: () {
                                        setState(() {
                                          showResend = true;
                                        });
                                      },
                                    )
                                  ],
                                ))
                      ],
                    ),
                    CustomButtons(
                        color: [Color(0xffF15741), Color(0xffF29F46)],
                        text: "Continue",
                        onPressed: widget.onPressed),
                    SizedBox(
                      height: height * .01,
                    ),
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
