import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/universal_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Screen/Auth/otp_verify.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var check = false;

  dynamic passObscure = true;
  dynamic pass1Obscure = true;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var pass1Controller = TextEditingController();

  _signUp() async {
    try {
      if (emailController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          passController.text.isNotEmpty &&
          pass1Controller.text.isNotEmpty) {
        if (passController.text == pass1Controller.text) {
          if (check) {
            showLoading(context);
            var username = nameController.text;
            var email = emailController.text;
            var password = passController.text;
            UniversalModel? model = await signUp(username, email, password);
            if (model!.status) {
              Navigator.pop(context);
              showSnackBar(context, "Registration Successful please login ${model.data}");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OtpVerifyPage(
                email: emailController.text,
              )), (route) => false);
            } else {
              Navigator.pop(context);
              showSnackBar(context, "${model.message}");
            }
          } else {
            showSnackBar(context, "Please accept the policy");
          }
        } else {
          showSnackBar(context, "Password doesn't match");
        }
      } else {
        showSnackBar(context, "Fill all details");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var font1 = GoogleFonts.inter(
        fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white);
    var font2 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white);
    var font3 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black);
    var font4 = GoogleFonts.inter(
        fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white);
    var font5 = GoogleFonts.inter(fontSize: 14, color: Colors.grey);

    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                      Image.asset(
                        "images/logo.png",
                        scale: 1.5,
                      ),
                      SizedBox(height: height * 0.02),
                      Text("Create an Account", style: font1),
                      SizedBox(height: height * 0.02),
                      Text(
                        "Use your credentials below and \nSign up to your account",
                        style: font2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: height * 0.02),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Container(
                              height: height * .57,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Name",
                                    style: font3,
                                  ),
                                  SizedBox(height: height * 0.005),
                                  CustomTextField(
                                    controller: nameController,
                                    hint: "Jane Cooper",
                                  ),
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    "Email Address",
                                    style: font3,
                                  ),
                                  SizedBox(height: height * 0.005),
                                  CustomTextField(
                                    controller: emailController,
                                    hint: "Eg namaemail@emailkamu.com",
                                  ),
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    "Password",
                                    style: font3,
                                  ),
                                  SizedBox(height: height * 0.005),
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
                                  SizedBox(height: height * 0.015),
                                  Text(
                                    "Confirm Password",
                                    style: font3,
                                  ),
                                  SizedBox(height: height * 0.005),
                                  CustomTextField(
                                    controller: pass1Controller,
                                    obscure: pass1Obscure,
                                    hint: "**** **** ****",
                                    icon: Icons.remove_red_eye_outlined,
                                    check: pass1Obscure,
                                    iconColor: pass1Obscure
                                        ? Colors.black
                                        : Color(0xffF15741),
                                    onPressed: () {
                                      setState(() {
                                        pass1Obscure = !pass1Obscure!;
                                      });
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                          activeColor: Color(0xffF15741),
                                          value: check,
                                          onChanged: (value) {
                                            setState(() {
                                              check = value!;
                                            });
                                          }),
                                      Text(
                                        "I agree all terms and conditions",
                                        style: font5,
                                      )
                                    ],
                                  ),
                                  CustomButtons(
                                    color: [
                                      Color(0xffF15741),
                                      Color(0xffF29F46)
                                    ],
                                    text: "Sign Up",
                                    onPressed: () {
                                      _signUp();
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
                            "Do have an account?",
                            style: font2,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Sign In",
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
    );
  }
}
