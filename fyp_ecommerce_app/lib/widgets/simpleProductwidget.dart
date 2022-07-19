import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/screens/product_explaination_screen.dart';
class SimpleProductWidget extends StatelessWidget {
  final ProductModel model;
  const SimpleProductWidget({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductExplanationScreen(  
               model: model
        )));
      },
      child: AspectRatio(
        aspectRatio: 1/1,
        child: Container(
          color:Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Image.network(model.url),
          ),
        ),
      ),
    );
  }
}