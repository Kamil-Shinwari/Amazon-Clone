import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';

class UserDetailProvider with ChangeNotifier {
  UserModel userModel;
  UserDetailProvider()
      : userModel = UserModel(name: "Loading", address: "Loading");

      Future getData()async{
        userModel=await CloudFirestoreClass().getNameAndAddress();
        notifyListeners();
      }
      
}
