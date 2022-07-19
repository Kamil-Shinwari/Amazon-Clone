import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/widgets/result_widget.dart';
import 'package:fyp_ecommerce_app/widgets/searchbar_widget.dart';

import '../models/product_model.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isreadOnly: false, hasBackButton: true),
      body: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: "Showing result for : ",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: query,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontStyle: FontStyle.italic),
                ),
              ]),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
              itemCount: 9,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 2/3),
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: ResultWidget(
                    model: ProductModel(
                        url:
                            "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
                        productName: "Shinwari Product" ,
                        cost: 100,
                        discount: 0,
                        uid: "eieiirjei",
                        sellerName: "Ahmad cosmetics",
                        sellerUid: "dkfjldk989",
                        rating: 3,
                        noOfRating: 1),
                  ),
                );
              }),
        ),
      ]),
    );
  }
}
