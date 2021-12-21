import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';

class VariationBottom extends StatefulWidget {
  final proColor;
  final proSize;
  const VariationBottom({Key? key, this.proColor, this.proSize}) : super(key: key);

  @override
  State<VariationBottom> createState() => _VariationBottomState();
}

class _VariationBottomState extends State<VariationBottom> {
  var selectedColor;

  int? selectedSize;

  var noOfPro = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height*.6,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
 Column(

   children: [
     FittedBox(
       child: Container(
           height: height*.08,
           width: width,
           decoration: BoxDecoration(
               color: Color(0xffF5F5F5),
               borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(20),
                   topRight: Radius.circular(20)
               )
           ),
           child: Center(child: Text("Variation" , style: GoogleFonts.inter(
               fontSize: 16 ,
               fontWeight: FontWeight.w600,
               color: Color(0xffEA5524)
           ),))),
     ),
     Container(
       child: Column(children: [
         ListTile(
           dense: true,
           title: Text("Color Family"),),
         Padding(
           padding: const EdgeInsets.symmetric(
               horizontal: 12),
           child: Align(
             alignment: Alignment.centerLeft,
             child: Wrap(
               children: widget.proColor
                   .map<Widget>((e) => Padding(
                 padding: const EdgeInsets
                     .symmetric(
                     horizontal: 4),
                 child: OutlinedButton(
                   style: ButtonStyle(
                       side: MaterialStateProperty.all(BorderSide(
                           color: selectedColor ==
                               e.color
                               ? Color(
                               primaryColor)
                               : Colors
                               .grey))),
                   onPressed: () {
                     setState(() {
                       selectedColor =
                           e.color;
                     });
                   },
                   child: Text(
                     e.color,
                     style: GoogleFonts.poppins(
                         fontWeight:
                         FontWeight.w600,
                         fontSize: 12,
                         color: selectedColor ==
                             e.color
                             ? Color(
                             primaryColor)
                             : Colors.grey),
                   ),
                 ),
               ))
                   .toList(),
             ),
           ),
         ),
       ],),),
     Container(
       child: Column(
         children: [
           ListTile(
             dense: true,
             title: Text("Sizes "),
           ),
           Padding(
             padding: const EdgeInsets.symmetric(
                 horizontal: 12),
             child: Align(
               alignment: Alignment.centerLeft,
               child: Wrap(
                 alignment: WrapAlignment.end,
                 children: widget.proSize
                     .toString()
                     .split(",")
                     .asMap()
                     .entries
                     .map((e) => Padding(
                   padding:
                   const EdgeInsets
                       .symmetric(
                       horizontal:
                       4),
                   child: OutlinedButton(
                     style: ButtonStyle(
                         side: MaterialStateProperty.all(BorderSide(
                             color: selectedSize ==
                                 e
                                     .key
                                 ? Color(
                                 primaryColor)
                                 : Colors
                                 .grey))),
                     onPressed: () {
                       setState(() {
                         selectedSize =
                             e.key;
                       });
                     },
                     child: Text(
                       "${e.value}",
                       style: GoogleFonts.poppins(
                           fontWeight:
                           FontWeight
                               .w600,
                           fontSize: 12,
                           color: selectedSize ==
                               e.key
                               ? Color(
                               primaryColor)
                               : Colors
                               .grey),
                     ),
                   ),
                 ))
                     .toList(),
               ),
             ),
           ),
         ],
       ),
     ),
     Divider(),
     Row(
       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: [
         Text("Quantity"),
         Row(
           children: [
             OutlinedButton(onPressed: (){}, child: Text("-")),
             SizedBox(width: 20,),
             Text("$noOfPro"),
             SizedBox(width: 20,),
             OutlinedButton(onPressed: (){}, child: Text("+")),
           ],)
       ],),
   ],
 ),
        Column(
          children: [
            Row(children: [
              SizedBox(
                width: width * .03,
              ),
              Expanded(
                child: CustomButtons(
                  onPressed: () {
                    // _addToCart(user.userId, widget.productId,
                    //     widget.price, widget.vendorId);
                  },
                  text: "Add to Cart",
                  color: [Color(0xffF15741), Color(0xffF29F46)],
                ),
              ),
              SizedBox(
                width: width * .03,
              ),
              Expanded(
                child: CustomButtons(
                  text: "Buy Now",
                  color: [Color(0xffF15741), Color(0xffF29F46)],
                ),
              ),
              SizedBox(
                width: width * .03,
              )
            ],),
            SizedBox(height: 10,)
          ],
        ),
      ],),
    );
  }
}
