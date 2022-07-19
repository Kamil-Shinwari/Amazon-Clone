import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/review_model.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/providers/user_detail_provider.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
class ReviewDialog extends StatelessWidget {
  final String productUid;
  const ReviewDialog({Key? key,required this.productUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      
      // your app's name?
      title: Text(
        'Type Reivew for this product',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      image: const FlutterLogo(size: 50),
      submitButtonText: 'Send',
      commentHint: 'Type Here',
     
      onSubmitted: (RatingDialogResponse response) async{
          CloudFirestoreClass().UploadReviewToDatabase(productUid: productUid, model: ReviewModel(
            senderName: Provider.of<UserDetailProvider>(context,listen: false).userModel.name, 
            description: response.comment,
           rating: response.rating.toInt()));
      },
    );
  }
}