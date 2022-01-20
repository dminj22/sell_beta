import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

// class CustomTextField extends StatelessWidget {
//   final obscure;
//
//   const CustomTextField({Key? key, this.hintText, this.obscure})
//       : super(key: key);
//
//   final hintText;
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     return SizedBox(
//       height: height * .055,
//       child: TextField(
//         obscureText: obscure,
//         style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
//         cursorColor: Color(0xffF29F46),
//         cursorHeight: 20,
//         cursorWidth: 2,
//         decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle:
//                 GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12),
//             contentPadding: EdgeInsets.only(left: 10),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1.5, color: Colors.black),
//                 borderRadius: BorderRadius.all(Radius.circular(5))),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1.5, color: Colors.black),
//                 borderRadius: BorderRadius.all(Radius.circular(5))),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(width: 1.5, color: Color(0xffF15741)),
//                 borderRadius: BorderRadius.all(Radius.circular(5)))),
//       ),
//     );
//   }
// }

class CustomButton extends StatelessWidget {
  final onPressed;

  const CustomButton(
      {Key? key,
      this.color1,
      this.color2,
      this.title,
      this.style,
      this.onPressed,
      this.imageUrl,
      this.shadow})
      : super(key: key);
  final color1;
  final color2;
  final title;
  final style;
  final imageUrl;
  final shadow;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: height * .047,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              //background color of box
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                blurRadius: 25.0, // b
                spreadRadius: 5.0, //0
                offset: Offset(
                  15.0, // x
                  15.0, // y
                ),
              )
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              colors: [
                color1,
                color2,
              ],
            ),
            color: Colors.deepPurple.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(6),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (imageUrl != null)
                  Image.asset(
                    imageUrl,
                    scale: 1.3,
                  ),
                if (imageUrl != null) SizedBox(width: width * .1),
                Text(title, style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final url;

  final title;

  final onTap;

  const DrawerListTile({Key? key, this.url, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          url,
          scale: 4,
          color: Color(0xffEA5524),
        ),
      ),
      title: Text(
        title,
        style:
            GoogleFonts.inter(fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}

class SCTextField extends StatelessWidget {
  const SCTextField(
      {Key? key, this.hint, this.suffix, this.autoFocus, this.obscure})
      : super(key: key);
  final hint;
  final suffix;
  final obscure;
  final autoFocus;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: 40,
      child: TextFormField(
        obscureText: obscure ?? false,
        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
            isDense: true,
            // Added this
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.5, color: Color(0xffF15741)),
                borderRadius: BorderRadius.all(Radius.circular(5)))),
        onSaved: (String? value) {
          // This optional block of code can be used to run
          // code when the user saves the form.
        },
        validator: (String? value) {
          return (value != null && value.contains('@'))
              ? 'Do not use the @ char.'
              : null;
        },
      ),
    );
  }
}

class AccountListTile extends StatelessWidget {
  const AccountListTile({Key? key, this.url, this.title, this.noDivider})
      : super(key: key);
  final url;
  final noDivider;

  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          dense: true,
          leading: Image.asset(
            url,
            scale: 4,
            color: Color(0xffEA5524),
          ),
          title: Text(
            title,
            style: GoogleFonts.mulish(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: noDivider ??
              Divider(
                height: 10,
                thickness: 1,
              ),
        )
      ],
    );
  }
}

//working

class CustomTextField extends StatelessWidget {
  final visible;

  final error;

  final hint;

  final keyboard;

  final onSaved;

  final onTap;

  final controller;

  final obscure;

  final suffix;

  final onPressed;

  final icon;

  final check;

  final iconColor;
  final enable;

  final initialValue;

  final label;

  const CustomTextField(
      {Key? key,
      this.visible,
      this.error,
      this.hint,
      this.keyboard,
      this.onSaved,
      this.onTap,
      this.controller,
      this.obscure,
      this.suffix,
      this.onPressed,
      this.icon,
      this.check,
      this.iconColor,
      this.enable,
      this.initialValue, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5))),
      width: width * 75 / 100,
      child: SizedBox(
        height: 45,
        child: TextFormField(
          keyboardType: keyboard,
          enabled: enable ?? true,
          controller: controller,
          obscureText: obscure ?? false,
          decoration: InputDecoration(
            label: label,
            contentPadding: EdgeInsets.only(left: 10),
            suffixIcon: suffix ??
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: IconButton(
                    icon: Icon(
                      icon,
                      color: iconColor,
                    ),
                    onPressed: onPressed,
                  ),
                ),
            hintText: hint,
            hintStyle:
                GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 12),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            errorStyle: TextStyle(fontSize: height * 1.5 / 100),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: const BorderSide(color: Colors.black, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1.5, color: Color(0xffE75423)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(width: 1.5, color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomButtons extends StatelessWidget {
  final onPressed;

  final text;

  final color;

  final imageUrl;

  const CustomButtons(
      {Key? key, this.onPressed, this.text, this.color, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            //background color of box
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 25.0, // b
              spreadRadius: 5.0, //0
              offset: Offset(
                15.0, // x
                15.0, // y
              ),
            )
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: color),
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: height * 5.7 / 100,
      width: width * 75 / 100,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl != null)
              Image.asset(
                imageUrl,
                scale: 1.3,
              ),
            if (imageUrl != null) SizedBox(width: width * .1),
            Text(
              "$text",
              style: TextStyle(
                  fontSize: height * 1.7 / 100,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: Color(0xffF15741),
      backgroundColor: Colors.white,
    );
  }
}

showSnackBar(context, msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    duration: Duration(seconds: 3),
  ));
}

showToast(message) {
  Fluttertoast.showToast(
      msg: "$message",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

Future<void> showLoading(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    )),
                Text(
                  "Loading",
                  style: GoogleFonts.inter(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class CustomAppBar extends StatelessWidget {
  final title;

  final action;

  const CustomAppBar({Key? key, this.title, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
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
      actions: action,
    );
  }
}
