import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificationBottomModel extends StatelessWidget {
  final proData;
  const SpecificationBottomModel({Key? key, this.proData}) : super(key: key);

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
            child: Center(child: Text("Specification" , style: GoogleFonts.inter(
                fontSize: 16 ,
                fontWeight: FontWeight.w600,
                color: Color(0xffEA5524)
            ),))),
        ListTile(title: Text("Brands"), subtitle: Text("${proData.brandName??""}"),),
        ListTile(title: Text("Sku"), subtitle: Text("${proData.sku??""}"),),
      ],),
    );
  }
}
