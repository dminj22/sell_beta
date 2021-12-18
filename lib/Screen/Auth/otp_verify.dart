import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/forget_password_model.dart';
import 'package:sell_beta_customer/Api/model/otp_verify_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({Key? key, this.email}) : super(key: key);
  final email;

  @override
  _OtpVerifyPageState createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String? getOtp;
  bool showResend = false;

  saveUser(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var font3 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
    var font5 = GoogleFonts.inter(
        fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black);
    var font6 = GoogleFonts.inter(
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff979797));
    var buttonColor = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xffF15741));

    _otpVerify() async {
      try {
        if (getOtp!.isNotEmpty) {
          showLoading(context);
          OtpVerifyModel? model = await otpVerify(widget.email, getOtp);
          if (model!.status) {
            saveUser(model.data!.userId);
            user.userId = model.data!.userId;
            Navigator.pop(context);
            showSnackBar(context, "Welcome ${model.data!.username}");
            Navigator.pushNamedAndRemoveUntil(
                context, "/home", (route) => false);
          } else {
            Navigator.pop(context);
            showSnackBar(context, model.message);
          }
        } else {
          Navigator.pop(context);
          showSnackBar(context, "Invalid Otp");
        }
      } catch (e) {
        showSnackBar(context, "Invalid Otp");
      }
    }
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

    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xffEA5524),
                    Color(0xffEA5524),
                    Color(0xffEA5524),
                    Color(0xffEA5524),
                    Color(0xffF7941D),
                  ],
                )),
                height: height * 0.964,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: height * .5,
                            width: width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        """Fill 4 digits code to verify the email address""",
                                        style: font6,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40),
                                        child: PinCodeTextField(
                                          keyboardType: TextInputType.number,
                                          length: 4,
                                          obscureText: false,
                                          cursorColor: Color(0xffEFEFEF),
                                          animationType: AnimationType.fade,
                                          pinTheme: PinTheme(
                                            inactiveFillColor:
                                                Color(0xffEFEFEF),
                                            inactiveColor: Colors.black,
                                            selectedFillColor:
                                                Color(0xffEFEFEF),
                                            selectedColor: Color(0xffF15741),
                                            activeColor: Colors.black,
                                            shape: PinCodeFieldShape.box,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            fieldHeight: 40,
                                            fieldWidth: 40,
                                            activeFillColor: Color(0xffEFEFEF),
                                          ),
                                          animationDuration:
                                              Duration(milliseconds: 300),
                                          enableActiveFill: true,
                                          onCompleted: (v) {
                                            print("Completed");
                                          },
                                          onChanged: (value) {
                                            getOtp = value;
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Don't receive OTP?",
                                        style: font3,
                                      ),
                                      showResend?
                                      Container(
                                        child: TextButton(
                                          onPressed: () async {
                                            resendOtp();
                                          },
                                          child: Text("Resend Otp"),
                                        ),
                                      ):
                                      TextButton(
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Resend after",
                                                style: buttonColor,
                                              ),
                                              Countdown(
                                                seconds: 128,
                                                build: (BuildContext context,
                                                        double time) =>
                                                    Text(
                                                  " ${time.toInt().toString()} sec",
                                                  style: buttonColor,
                                                ),
                                                interval: Duration(seconds: 1),
                                                onFinished: () {
                                                  setState(() {
                                                    showResend = true;
                                                  });
                                                  print('Timer is done!');
                                                },
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                  CustomButtons(
                                      color: [
                                        Color(0xffF15741),
                                        Color(0xffF29F46)
                                      ],
                                      text: "Continue",
                                      onPressed: () {
                                        _otpVerify();
                                      }),
                                  SizedBox(
                                    height: height * .01,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  top: -30,
                  left: -30,
                  child: Opacity(
                    opacity: 0.15,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffF7F7F7),
                      radius: 61,
                    ),
                  )),
              Positioned(
                  top: -20,
                  right: -50,
                  child: Opacity(
                    opacity: 0.15,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffF7F7F7),
                      radius: 80,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
