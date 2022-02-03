import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/forget_otp_verify_model.dart';
import 'package:sell_beta_customer/Api/model/forget_password_model.dart';
import 'package:sell_beta_customer/Api/model/forget_update_password_model.dart';
import 'package:sell_beta_customer/Api/model/login_model.dart';
import 'package:sell_beta_customer/Api/model/otp_verify_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/forgot_pass.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/otp_verify.dart';
import 'package:sell_beta_customer/Component/bottom_sheet/reset_password.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_count_down.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailModelController = TextEditingController();
  var otpModelController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var pass1Controller = TextEditingController();
  var pass2Controller = TextEditingController();

  saveUser(userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  String? currentText;

  dynamic passObscure = true;

  _login() async {
    print(emailController.text);
    try {
      if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
        showLoading(context);
        var email = emailController.text;
        var password = passController.text;
        LoginModel? model = await login(email, password);
        if (model!.status) {
          saveUser(model.data![0].userId.toString());
          showSnackBar(context, model.message);
          return model;
        } else {
          Navigator.pop(context);
          showSnackBar(context, model.message);
        }
      } else {
        showSnackBar(context, "Enter Email & Password");
      }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, "$e");
    }
  }

  _forgetPassword() async {
    try {
      if (emailModelController.text.isNotEmpty) {
        ForgetPasswordModel? model =
            await forgetPassword(emailModelController.text);
        if (model!.status) {
          return model;
        } else {
          return model;
        }
      } else {
        showToast("Please Enter Email");
      }
    } catch (e) {
      showToast("$e");
    }
  }

  _forgetOtpVerify(email, otp) async {
    try {
      if (otp != null) {
        ForgetOtpVerifyModel? model = await forgotOtpVerify(email, otp);
        if (model!.status) {
          return model;
        } else {
          return model;
        }
      } else {
        showToast("Enter Otp");
      }
    } catch (e) {
      showToast(e);
    }
  }

  _updatePassword() async {
    try {
      if (pass1Controller.text.isNotEmpty && pass2Controller.text.isNotEmpty) {
        if (pass1Controller.text == pass2Controller.text) {
          ForgetUpdatePasswordModel? model = await forgetUpdatePassword(
              emailModelController.text, pass1Controller.text);
          if (model!.status) {
            return model;
          } else {
            return model;
          }
        } else {
          showToast('Password not matched');
        }
      } else {
        showToast("Please Enter Password");
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    var font1 = GoogleFonts.inter(
        fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white);
    var font2 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
    var font3 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
    var font4 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);

    resetPass() {
      showModalBottomSheet(
          enableDrag: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return ResetPassSheet(
              pass1: pass1Controller,
              pass2: pass2Controller,
              onPressed: () async {
                ForgetUpdatePasswordModel model = await _updatePassword();
                if (model.status) {
                  emailModelController.clear();
                  pass1Controller.clear();
                  pass2Controller.clear();
                  user.otp = null;
                  Navigator.pop(context);
                  showSnackBar(context, "${model.message}, Please Login");
                } else {
                  showToast(model.message);
                }
              },
            );
          });
    }

    showOtp() {
      showModalBottomSheet(
          enableDrag: false,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return OtpModalSheet(
              email: emailModelController.text,
              onPressed: () async {
                var model =
                    await _forgetOtpVerify(emailModelController.text, user.otp);
                if (model.status) {
                  Navigator.pop(context);
                  showToast("${model.message}");
                  resetPass();
                } else {
                  showToast("${model.message}");
                }
              },
            );
          });
    }

    showForgotPass() {
      showModalBottomSheet(

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
          isScrollControlled: true,
          context: context,
          builder: (_) {
            return ForgotModalSheet(
              emailModelController: emailModelController,
              onPressed: () async {
                var model = await _forgetPassword();
                if (model.status) {
                  Navigator.pop(context);
                  showToast("${model.message}");
                  showOtp();
                } else {
                  showToast(model.message);
                }
              },
            );
          });
    }

    return SafeArea(
      child: KeyboardDismisser(
        gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
        child: Scaffold(
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
                    width: width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              "images/logo.png",
                              scale: 1.5,
                            ),
                            SizedBox(height: height * 0.02),
                            Text("Sign In Account", style: font1),
                            SizedBox(height: height * 0.02),
                            Text(
                              "Use your credentials below and \nlogin to your account",
                              style: font2,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 22),
                              child: Container(
                                height: height * .57,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email Address",
                                      style: font3,
                                    ),
                                    SizedBox(height: height * 0.01),
                                    CustomTextField(
                                      controller: emailController,
                                      hint: "Eg namaemail@emailkamu.com",
                                    ),
                                    SizedBox(height: height * 0.02),
                                    Text(
                                      "Password",
                                      style: font3,
                                    ),
                                    SizedBox(height: height * 0.01),
                                    CustomTextField(
                                      controller: passController,
                                      obscure: passObscure,
                                      hint: "**** **** ****",
                                      icon: Icons.remove_red_eye_outlined,
                                      check: passObscure,
                                      iconColor: passObscure
                                          ? Colors.black
                                          : Color(0xffF15741),
                                      onPressed: () {
                                        setState(() {
                                          passObscure = !passObscure!;
                                          print(passObscure);
                                        });
                                      },
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                          padding: MaterialStateProperty.all(
                                              EdgeInsets.zero)),
                                      onPressed: () {
                                        showForgotPass();
                                        // showOtp();
                                      },
                                      child: Text(
                                        "Forgot Password ?",
                                        style: font3,
                                      ),
                                    ),
                                    CustomButtons(
                                      color: [
                                        Color(0xffF15741),

                                        Color(0xffF29F46)
                                      ],
                                      text: "Sign In",
                                      onPressed: () async {
                                    LoginModel model = await  _login();
                                    if(model.status){
                                      Navigator.pop(context);
                                      user.userId = model.data![0].userId.toString();
                                      Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
                                    }else{
                                      print("error");
                                    }

                                        print("${user.userId} >>>>>>>>>>>>>>>>>>>.");
                                      },
                                    ),
                                    Row(
                                      children: [
                                        Expanded(child: Divider()),
                                        Text(
                                          " or ",
                                          style: TextStyle(
                                              color: Color(0xffC9C9C9)),
                                        ),
                                        Expanded(child: Divider())
                                      ],
                                    ),
                                    CustomButtons(
                                      color: [
                                        Color(0xffEA4335),
                                        Color(0xffEA4335)
                                      ],
                                      imageUrl: "images/google.png",
                                      text: "Continue with Google",
                                      onPressed: () {
                                        // Navigator.pushNamed(context, '/home');
                                      },
                                    ),
                                    SizedBox(
                                      height: height * .02,
                                    ),
                                    CustomButtons(
                                      color: [
                                        Color(0xff1877F2),
                                        Color(0xff1877F2)
                                      ],
                                      imageUrl: "images/facebook.png",
                                      text: "Continue with Facebook",
                                      onPressed: () {
                                        // Navigator.pushNamed(context, '/home');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: font2,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/signUpPage');
                                },
                                child: Text(
                                  "Sign Up",
                                  style: font4,
                                )),
                          ],
                        )
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
        ),
      ),
    );
  }
}

//bottom sheet Modal
