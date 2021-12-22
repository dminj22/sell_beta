import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/add_to_cart_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/theme.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';

class VariationBottom extends StatefulWidget {
  final proColor;
  final proSize;
  final proData;

  const VariationBottom({Key? key, this.proColor, this.proSize, this.proData})
      : super(key: key);

  @override
  State<VariationBottom> createState() => _VariationBottomState();
}

class _VariationBottomState extends State<VariationBottom> {

  var selectedColor;

  int? selectedSize;

  var noOfPro = 1;

  String? sizeValue;

  _addToCart(userId, prodId, price, vendorId, quantity, size, color) async {
    try {
      if (selectedColor != null && selectedSize != null) {
        if (userId != null&& prodId != null&& price != null&& vendorId != null&& quantity != null&& size!= null && color != null) {
          AddToCartModel? model = await addToCart(
              userId,
              vendorId,
              prodId,
              quantity,
              price,
              size,
              color);
          if (model!.status) {
            Navigator.pop(context);
            showToast(model.message);
          } else {
            showToast(model.message);
          }
        } else {
          showToast("Something Went Wrong");
        }
      } else {
        showToast("Select Size and Color");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var user = Provider.of<UserProvider>(context);
    return Container(
      height: height * .8,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              FittedBox(
                child: Container(
                    height: height * .08,
                    width: width,
                    decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Center(
                        child: Text(
                          "Variation",
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffEA5524)),
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
                child: Row(
                  children: [
                    widget.proData.imgUrl != null
                        ? Container(
                      width: width * .2,
                      height: height * .1,
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                              NetworkImage(widget.proData.imgUrl))),
                    )
                        : Image.asset('images/sample/no_image.jpg'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 23),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(widget.proData.salePriceCurrency ?? ""),
                              Text(
                                  "${double.parse(widget.proData.salePrice) *
                                      noOfPro}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("${widget.proData.discount ?? " "}% OFF")
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text("Color Family"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          children: widget.proColor
                              .map<Widget>((e) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color:
                                              selectedColor == e.color
                                                  ? Color(primaryColor)
                                                  : Colors.grey))),
                                  onPressed: () {
                                    setState(() {
                                      selectedColor = e.color;
                                    });
                                  },
                                  child: Text(
                                    e.color,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: selectedColor == e.color
                                            ? Color(primaryColor)
                                            : Colors.grey),
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
              Container(
                child: Column(
                  children: [
                    ListTile(
                      dense: true,
                      title: Text("Sizes "),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: widget.proSize
                              .toString()
                              .split(",")
                              .asMap()
                              .entries
                              .map((e) =>
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4),
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          BorderSide(
                                              color: selectedSize == e.key
                                                  ? Color(primaryColor)
                                                  : Colors.grey))),
                                  onPressed: () {
                                    setState(() {
                                      selectedSize = e.key;
                                      sizeValue = e.value;
                                    });
                                  },
                                  child: Text(
                                    "${e.value}",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: selectedSize == e.key
                                            ? Color(primaryColor)
                                            : Colors.grey),
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
                      OutlinedButton(
                          onPressed: () {
                            if (noOfPro > 1) {
                              setState(() {
                                noOfPro--;
                              });
                            }
                          },
                          child: Text("-")),
                      SizedBox(
                        width: 20,
                      ),
                      Text("$noOfPro"),
                      SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            setState(() {
                              noOfPro++;
                            });
                          },
                          child: Text("+")),
                    ],
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width * .03,
                  ),
                  Expanded(
                    child: CustomButtons(
                      onPressed: () {
                        var userId = user.userId;
                        var prodId = widget.proData.productId;
                        var price = "${double.parse(widget.proData.salePrice) *
                            noOfPro}";
                        var vendorId = widget.proData.vendorId;
                        var quantity = "$noOfPro";
                        var size = "$sizeValue";
                        var color = "$selectedColor";
                        _addToCart(
                            userId,
                            prodId,
                            price,
                            vendorId,
                            quantity,
                            size,
                            color);
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
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
