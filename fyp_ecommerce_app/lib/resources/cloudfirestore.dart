import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/models/review_model.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/simpleProductwidget.dart';

class CloudFirestoreClass {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future uploadNameAndAddressToDatabase({required UserModel model}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .set(model.getjson());
  }

  Future getNameAndAddress() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserModel userModel = UserModel.getModelFromJson(snap.data() as dynamic);
    return userModel;
  }

  Future<String> uploadPeoductToDatabase({
    required Uint8List? image,
    required String ProductName,
    required String rawCost,
    required int discount,
    required String sellerName,
    required String sellerUid,
    // required int rating,
    // required int NoOfRating,
  }) async {
    ProductName.trim();
    rawCost.trim();
    String output = "something Went Wrong";
    if (image != null && ProductName != "" && rawCost != "") {
      try {
        String uid = utils().getUid();
        String url = await uploadImageToDatabase(image: image, uid: uid);
        double cost = double.parse(rawCost);
        cost = cost - (cost * (discount / 100));
        ProductModel productModel = ProductModel(
            url: url,
            productName: ProductName,
            cost: cost,
            discount: discount,
            uid: uid,
            sellerName: sellerName,
            sellerUid: sellerUid,
            rating: 5,
            noOfRating: 0);
        await FirebaseFirestore.instance
            .collection("products")
            .doc(uid)
            .set(productModel.getJson());
        output = "success";
      } catch (e) {
        output = e.toString();
      }
    } else {
      output = "plz make sure all the field are not empty";
    }
    return output;
  }

  Future<String> uploadImageToDatabase(
      {required Uint8List image, required String uid}) async {
    Reference storageref =
        FirebaseStorage.instance.ref().child('products').child(uid);
    UploadTask uploadTask = storageref.putData(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return taskSnapshot.ref.getDownloadURL();
  }

  Future<List<Widget>> getProductFromDiscount(int discount) async {
    List<Widget> children = [];
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection("products")
        .where("discount", isEqualTo: discount)
        .get();
    for (int i = 0; i < snap.docs.length; i++) {
      DocumentSnapshot documentSnapshot = snap.docs[i];
      ProductModel model =
          ProductModel.getModelFromJson(documentSnapshot.data() as dynamic);
      children.add(SimpleProductWidget(model: model));
    }
    return children;
  }

  Future UploadReviewToDatabase(
      {required String productUid, required ReviewModel model}) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(productUid)
        .collection("reviews")
        .add(model.getJson());
  }

  Future addProductToCart({required ProductModel model}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(model.uid)
        .set(model.getJson());
  }

  Future deleteProductFromCart({required String uid}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .doc(uid)
        .delete();
  }

  Future buyAllItemsInCart() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("cart")
        .get();

        for(int i=0;i<snapshot.docs.length;i++){
          ProductModel model=ProductModel.getModelFromJson(snapshot.docs[i].data());
         addProductToOrdrs(model: model);
          await deleteProductFromCart(uid: model.uid);
        }
  }

  Future addProductToOrdrs({required ProductModel model}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .collection("orders")
        .add(model.getJson());
       
  }
}
