import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Config/theme.dart';

class VendorFeeds extends StatefulWidget {
  const VendorFeeds({Key? key}) : super(key: key);

  @override
  _VendorFeedsState createState() => _VendorFeedsState();
}

class _VendorFeedsState extends State<VendorFeeds> {
  dynamic item = [
    {"i": "#Currently Wearing"},
    {"i": "#Currently Wearing"},
    {"i": "#Currently Wearing"},
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Card(
      child: ListView(
        children: [
          ListTile(
            leading: Container(
              height: height * .1,
              width: width * .15,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage('images/sample/pofile.png'))),
            ),
            title: Text(
              "Primo Space >",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black),
            ),
            subtitle: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color(0xffFFD4CE)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shop,
                          size: 10,
                          color: Color(primaryColor),
                        ),
                        Text(
                          "Store",
                          style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: Color(primaryColor)),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "771 Followers",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 10),
                )
              ],
            ),
            trailing: Container(
              height: height * .05,
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
                      colors: [Color(0xffF15741), Color(0xffF29F46)]),
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: () {},
                child: Text("Follow"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/sample/sample1.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint.",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xffABABAB)),
            ),
          ),
          Wrap(
            children: item.map<Widget>((e)=>Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Chip(
                  padding: EdgeInsets.zero,
                  label: Text("${e["i"]}" , style: GoogleFonts.inter(
                fontSize: 8 , fontWeight: FontWeight.w400 , color: Color(primaryColor)
              ),)),
            )).toList()
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                TextButton.icon(onPressed: (){}, icon: Icon(Icons.favorite_border , color: Colors.grey,), label: Text("25" , style: TextStyle(color: Colors.grey),)),
                TextButton.icon(onPressed: (){}, icon: Icon(Icons.chat_bubble_outline , color: Colors.grey,), label: Text("251" , style: TextStyle(color: Colors.grey),)),
                IconButton(onPressed: (){}, icon: Icon(Icons.share)),

              ],),
              IconButton(onPressed: (){}, icon: Icon(Icons.more_vert))
            ],
          )
        ],
      ),
    );
  }
}
