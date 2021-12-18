import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceModel extends StatelessWidget {
  const ServiceModel({Key? key}) : super(key: key);

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
            child: Center(child: Text("Services" , style: GoogleFonts.inter(
                fontSize: 16 ,
                fontWeight: FontWeight.w600,
                color: Color(0xffEA5524)
            ),))),
        ListTile(title: Text("7 days return to seller") , subtitle: Text("Change of mind is not applicable"),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('''Direct return to merchant within 7 days. Seller should approve return and
refund. After seller accepts return request, send the item to seller for
processing refund.''' , style: GoogleFonts.poppins(fontWeight: FontWeight.w400 , fontSize: 10), textAlign: TextAlign.justify,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(thickness: 1,),
        )
      ],),
    );
  }
}
