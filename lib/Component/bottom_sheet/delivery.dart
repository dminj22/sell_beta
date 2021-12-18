import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class DeliveryModel extends StatelessWidget {
  const DeliveryModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height/2,
      width: width,
      child: Column(children: [
        Container(
          height: height*.08,
            width: width,
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
              )
            ),
            child: Center(child: Text("Delivery Options" , style: GoogleFonts.inter(
              fontSize: 16 ,
              fontWeight: FontWeight.w600,
              color: Color(0xffEA5524)
            ),))),
        ListTile(
          title: Text("Delivery Options" , style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          trailing: Text("Place name"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(thickness: 1,),
        ),
        ListTile(
          title: Text("Delivery Fee", style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          subtitle: Text("Home Delivery (2-8 days)"),
          trailing: Text("6,900"),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(thickness: 1,),
        ),
        ListTile(
          title: Text("Delivery Free", style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
          subtitle: Text("Home Delivery (2-8 days)"),
          trailing: Text("Place name"),
        ),
      ],),
    );
  }
}
