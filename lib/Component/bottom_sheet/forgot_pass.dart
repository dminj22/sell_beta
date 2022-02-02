import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Widgets.dart';

class ForgotModalSheet extends StatelessWidget {
  final onPressed;

  final emailModelController;

  const ForgotModalSheet({Key? key, this.onPressed, this.emailModelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xff979797));
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            height: height * .5,
            width: width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
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
                          "Forgot password",
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
                    height: height * .03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Email Address",
                          style: font3,
                        ),
                      ),
                      CustomTextField(
                        controller: emailModelController,
                        hint: "abc@gmail.com",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * .03,
                  ),
                  CustomButtons(
                      color: [Color(0xffF15741), Color(0xffF29F46)],
                      text: "Continue",
                      onPressed: onPressed),
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
    );
  }
}