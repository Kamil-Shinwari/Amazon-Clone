import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';
import 'package:fyp_ecommerce_app/screens/product_explaination_screen.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/custom_simple_rounded_button.dart';
import 'package:fyp_ecommerce_app/widgets/custom_squre_button.dart';
import 'package:fyp_ecommerce_app/widgets/product_information_widget.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel productModel;
  const CartItemWidget({Key? key,required this.productModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = utils().getScreenSize();
    int quantity=0;
    return Container(
      padding: EdgeInsets.all(20),
      height: screensize.height / 3,
      width: screensize.width,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: GestureDetector(
              onTap: (){
                 Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                   ProductExplanationScreen(model: productModel)));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width:screensize.width/3,
                    child: Expanded(
                      child: Image.network(
                          productModel.url),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  Expanded(
                    child: ProductInformationWidget(
                        productName: productModel.productName,
                        cost: productModel.cost,
                        sellerName: productModel.sellerName),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: Row(
                  
                  children: [
                    CustomSqureButton(
                      child: Center(child: Icon(Icons.remove)),
                      onpressed: () {
                        
                      },
                      dimension: 40,
                      color: backgroundColor,
                    ),
                    SizedBox(width: 8,),
                     CustomSqureButton(
                      child: Center(child: Text("0",style: TextStyle(color: activeCyanColor),)),
                      onpressed: () {
                       
                      },
                      dimension: 40,
                      color: Colors.white,
                    ),
                     SizedBox(width: 8,),
                     CustomSqureButton(
                      child: Center(child: Icon(Icons.add)),
                      onpressed: () async{
                        await CloudFirestoreClass().addProductToCart(model: ProductModel(
                          url: productModel.url, 
                          productName: productModel.productName, 
                          cost: productModel.cost,
                           discount: productModel.discount, 
                           uid: productModel.uid, 
                           sellerName: productModel.sellerName, 
                           sellerUid: productModel.sellerUid, 
                           rating: productModel.rating, 
                           noOfRating: productModel.noOfRating));
                      },
                      dimension: 40,
                      color: backgroundColor,
                    ),
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child:Align(
              alignment: Alignment.topLeft,
              child: FittedBox(
                child: Column(
                   mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                     
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      CustomSimpleRoundedButton(text: "Delete", onprssed: () async{
                        CloudFirestoreClass().deleteProductFromCart(uid: productModel.uid);
                      }),
                      SizedBox(width: 10,),
                      CustomSimpleRoundedButton(text: "Save For later", onprssed: (){}),
                    ],),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: GestureDetector(onTap: (){},child: Text('See More like This',style: TextStyle(color: activeCyanColor),)),
                    )
                  ],
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
