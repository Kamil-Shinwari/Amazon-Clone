import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/models/review_model.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/custom_mainButton.dart';
import 'package:fyp_ecommerce_app/widgets/custom_simple_rounded_button.dart';
import 'package:fyp_ecommerce_app/widgets/rating_star_widget.dart';
import 'package:fyp_ecommerce_app/widgets/review_dialog.dart';
import 'package:fyp_ecommerce_app/widgets/review_widget.dart';
import 'package:fyp_ecommerce_app/widgets/searchbar_widget.dart';

import '../models/user_detail_model.dart';
import '../widgets/user_details_bar.dart';

class ProductExplanationScreen extends StatefulWidget {
  final ProductModel model;
  const ProductExplanationScreen({Key? key, required this.model})
      : super(key: key);

  @override
  State<ProductExplanationScreen> createState() =>
      _ProductExplanationScreenState();
}

class _ProductExplanationScreenState extends State<ProductExplanationScreen> {
  @override
  Widget build(BuildContext context) {
    Size Screensize = utils().getScreenSize();
    Expanded spacethingy=Expanded(child: Container(),);
    return SafeArea(
        child: Scaffold(
      appBar: SearchBarWidget(hasBackButton: true, isreadOnly: true),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: Screensize.height - (kAppBarHeight + (kAppBarHeight/2)),
                  child: Column(children: [
                    SizedBox(
                      height: kAppBarHeight / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Text(
                                  widget.model.sellerName,
                                  style: TextStyle(
                                      fontSize: 15, color: activeCyanColor),
                                ),
                              ),
                              Text(widget.model.productName),
                            ],
                          ),
                          RatingStarWidget(rating: widget.model.rating)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: Screensize.height/3,
                        constraints: BoxConstraints(
                          maxHeight: Screensize.height / 3,
                        ),
                        child: Image.network("${widget.model.url}"),
                      ),
                    ),
                    spacethingy,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "₹",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                       
                        Text(
                          "${widget.model.cost}",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                    spacethingy,
                    MainCustomButton(
                        child: Text(
                          'Buy Now',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        color: Colors.orange,
                        isloading: true,
                        onPressed: () async{
                        await  CloudFirestoreClass().addProductToOrdrs(model: widget.model);
                        utils().ShowSnackBar(context: context, content:"Done");
                        }),
                        spacethingy,
                    MainCustomButton(
                        child: Text(
                          'Add to Cart',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                        color: yellowColor,
                        isloading: true,
                        onPressed: () async{
                          CloudFirestoreClass().addProductToCart(model: widget.model);
                          utils().ShowSnackBar(context: context, content: "Added to Cart");
                        }),
                    SizedBox(
                      height: 15,
                    ),
                    CustomSimpleRoundedButton(
                        text: "Add a review for this product", onprssed: () {
                          showDialog(context: context, builder: (context)=>ReviewDialog(productUid: widget.model.uid,));
                        }),
                  ]),
                ),
                SizedBox(height: Screensize.height,
                child:StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("products").doc(widget.model.uid).collection("reviews").snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return Container();
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                      ReviewModel reviewModel=ReviewModel.getModelFromJson(json:snapshot.data!.docs[index].data());
                      return ReviewWidget(reviewModel: reviewModel);
                    },);
                  }
                },) ),
              ],
            ),
          ),
        ),
        UserDetailBar(
          offset: 0,
         
        ),
      ]),
    ));
  }
}
