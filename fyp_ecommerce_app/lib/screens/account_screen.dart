import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/providers/user_detail_provider.dart';
import 'package:fyp_ecommerce_app/screens/sell_screen.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/Product_showCase_list_view.dart';
import 'package:fyp_ecommerce_app/widgets/account_screen_appbar.dart';
import 'package:fyp_ecommerce_app/widgets/custom_mainButton.dart';
import 'package:provider/provider.dart';

import '../models/order_request_model.dart';
import '../widgets/simpleProductwidget.dart';

class AccoountScreen extends StatefulWidget {
  const AccoountScreen({Key? key}) : super(key: key);

  @override
  State<AccoountScreen> createState() => _AccoountScreenState();
}

class _AccoountScreenState extends State<AccoountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screensize = utils().getScreenSize();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const AccountScrenAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            height: screensize.height,
            width: screensize.width,
            child: Column(children: [
              const IntroductoryWidgetAccountScreen(),
              MainCustomButton(
                  child: const Text(
                    'Sign-In',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Colors.orange,
                  isloading: true,
                  onPressed: () {}),
              MainCustomButton(
                  child: const Text(
                    'Sell',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: yellowColor,
                  isloading: true,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SellScreen()));
                  }),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("ordrs")
                    .get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    List<Widget> children = [];
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      ProductModel model = ProductModel.getModelFromJson(
                          snapshot.data!.docs[i].data());
                          children.add(SimpleProductWidget(model: model));
                          
                    }
                    return ProductShowCaseListView(title: "your order", children: children);
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Order Request",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    )),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  OrderRequestModel model= OrderRequestModel(orderName: "ice with mice", buyerAddress: "some where on earth");
                  return ListTile(
                    title: Text('${model.orderName}'),
                    subtitle: Text("${model.buyerAddress}"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.check),
                    ),
                  );
                },
              ))
            ]),
          ),
        ));
  }
}

class IntroductoryWidgetAccountScreen extends StatelessWidget {
  const IntroductoryWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserDetailProvider>(context).userModel;
    return Container(
      height: kAppBarHeight / 2,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: backgroundGradient,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white.withOpacity(0.00000000001),
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "Hello,  ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 27,
                  )),
              TextSpan(
                  text: "${userModel.name}",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 27,
                      fontWeight: FontWeight.bold))
            ])),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg"),
            ),
          )
        ]),
      ),
    );
  }
}
