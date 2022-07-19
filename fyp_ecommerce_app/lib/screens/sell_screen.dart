import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/providers/user_detail_provider.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/custom_mainButton.dart';
import 'package:fyp_ecommerce_app/widgets/loading_widget.dart';
import 'package:fyp_ecommerce_app/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isloading = false;
  int selected = 1;
  Uint8List? images;

  @override
  Widget build(BuildContext context) {
    Expanded spaceThingy = Expanded(child: Container());
    Size size = utils().getScreenSize();
    TextEditingController itemNameController = TextEditingController();
    TextEditingController itemCostController = TextEditingController();
    List<int> keyofDiscount = [0, 70, 60, 50];
   
    return Scaffold(
      body: SafeArea(
          child: !isloading
              ? SingleChildScrollView(
                  child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              images == null
                                  ? Stack(
                                      children: [
                                        Image.network(
                                          "https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png",
                                          height: size.height / 8,
                                        ),
                                        Positioned(
                                          right: -10,
                                          bottom: -10,
                                          child: IconButton(
                                              onPressed: () async {
                                                Uint8List? list =
                                                    await utils().pickImage();
                                                if (list != null) {
                                                  setState(() {
                                                    images = list;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                  Icons.add_a_photo_outlined)),
                                        ),
                                      ],
                                    )
                                  : Stack(
                                      children: [
                                        Image.memory(
                                          images!,
                                          height: size.height / 8,
                                        ),
                                        Positioned(
                                          right: -10,
                                          bottom: -10,
                                          child: IconButton(
                                              onPressed: () async {
                                                Uint8List? list =
                                                    await utils().pickImage();
                                                if (list != null) {
                                                  setState(() {
                                                    images = list;
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                  Icons.add_a_photo_outlined)),
                                        )
                                      ],
                                    ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                width: size.width * 0.8,
                                height: size.height * 0.8,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextFieldWidget(
                                          hinttext: "enter Name of the Item",
                                          title: "Item Name",
                                          editingController: itemNameController,
                                          obsecureText: false),
                                      TextFieldWidget(
                                          hinttext: "enter Cost of the Item",
                                          title: "Cost",
                                          editingController: itemCostController,
                                          obsecureText: false),
                                      Text(
                                        "Discount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      ListTile(
                                        title: Text("None"),
                                        leading: Radio(
                                            value: 1,
                                            groupValue: selected,
                                            onChanged: (int? i) {
                                              setState(() {
                                                selected = i!;
                                              });
                                            }),
                                      ),
                                      ListTile(
                                        title: Text("70%"),
                                        leading: Radio(
                                            value: 2,
                                            groupValue: selected,
                                            onChanged: (int? i) {
                                              setState(() {
                                                selected = i!;
                                              });
                                            }),
                                      ),
                                      ListTile(
                                        title: Text("60%"),
                                        leading: Radio(
                                            value: 3,
                                            groupValue: selected,
                                            onChanged: (int? i) {
                                              setState(() {
                                                selected = i!;
                                              });
                                            }),
                                      ),
                                      ListTile(
                                        title: Text("50%"),
                                        leading: Radio(
                                            value: 4,
                                            groupValue: selected,
                                            onChanged: (int? i) {
                                              setState(() {
                                                selected = i!;
                                              });
                                            }),
                                      ),
                                    ]),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MainCustomButton(
                                  child: Text(
                                    "Sell",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: yellowColor,
                                  isloading: true,
                                  onPressed: () async {
                                    String output = await CloudFirestoreClass()
                                        .uploadPeoductToDatabase(
                                      image: images,
                                      ProductName: itemNameController.text,
                                      rawCost: itemCostController.text,
                                      discount: keyofDiscount[selected - 1],
                                      sellerName: Provider.of<UserDetailProvider>(
                                              context,
                                              listen: false)
                                          .userModel.name,
                                      sellerUid: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                                    if (output == "success") {
                                      utils().ShowSnackBar(
                                          context: context,
                                          content:
                                              "product successfully posted");
                                    }else{
                                      utils().ShowSnackBar(context: context, content: output);
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: MainCustomButton(
                                    child: Text(
                                      "Back",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    color: Colors.grey.shade500,
                                    isloading: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ))
              : LoadinWidget()),
    );
  }
}
