import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/cart_item_widget.dart';
import 'package:fyp_ecommerce_app/widgets/custom_mainButton.dart';
import 'package:fyp_ecommerce_app/widgets/searchbar_widget.dart';
import 'package:fyp_ecommerce_app/widgets/user_details_bar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Size screensize = utils().getScreenSize();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SearchBarWidget(
          hasBackButton: false,
          isreadOnly: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream:FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("cart")
                      .snapshots(), 
                    builder:  (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return MainCustomButton(
                          child: Text("Loading"), 
                        color: yellowColor, 
                        isloading: false,
                         onPressed: (){});
                      }
                      else{
                        return MainCustomButton(
                          child: Text("Proceed to buy ${snapshot.data!.docs.length} items"), 
                        color: yellowColor, 
                        isloading: true,
                         onPressed: () async{
                          await CloudFirestoreClass().buyAllItemsInCart();
                          utils().ShowSnackBar(context: context, content: "done");
                         });
                      }
                    },)
                ),
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("cart")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Container();
                      }else{
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel productModel=ProductModel.getModelFromJson(snapshot.data!.docs[index].data());
                          return CartItemWidget(productModel: productModel);
                          },);
                      }
                  },
                )),
              ],
            ),
            UserDetailBar(
              offset: 0,
            ),
          ],
        ));
  }
}
