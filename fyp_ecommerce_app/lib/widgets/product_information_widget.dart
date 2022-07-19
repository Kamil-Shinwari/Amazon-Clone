import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';

import 'cost_widget.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  const ProductInformationWidget(
      {Key? key,
      required this.productName,
      required this.cost,
      required this.sellerName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size Screensize = utils().getScreenSize();
    SizedBox spaceThingy=SizedBox(height: 7,);
    return Column(
     
      mainAxisSize: MainAxisSize.max,
       mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            productName,
            maxLines: 2,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      //   // spaceThingy,
      //  Expanded(child: CostWidget(color: Colors.black, cost: cost)),
      Row(children: [
        Text("₹",style: TextStyle(fontSize: 20),),
        SizedBox(width: 10,),
        Text("$cost",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
      ],),
      
      //  spaceThingy,
        RichText(text: TextSpan(children: [
          TextSpan(text: "Sold By :",style: TextStyle(color:Colors.grey.shade700)),
          // ignore: prefer_const_constructors
              
          TextSpan(text: sellerName,style: TextStyle(color: activeCyanColor)),
        ])),
      ],
    );
  }
}
