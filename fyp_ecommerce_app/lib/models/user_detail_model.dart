import 'package:flutter/material.dart';
class UserModel{
  final String name;
  final String address;
  UserModel({required this.name,required this.address});
  Map<String,dynamic> getjson()=>{
    "name":name,
    "address":address,
  };
 factory UserModel.getModelFromJson(Map<String,dynamic> json){
    return UserModel(name: json["name"], address: json["address"]);
  }
}