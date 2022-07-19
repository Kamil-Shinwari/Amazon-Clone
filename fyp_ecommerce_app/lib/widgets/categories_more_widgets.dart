import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/screens/result_screen.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';

class CategoriesMoreWidget extends StatelessWidget {
  final int index;
  const CategoriesMoreWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen(query: categoriesList[index])));
      },
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8),
              
        ]),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(categoryLogos[index]),
            ),
            Text(
              categoriesList[index],
              style: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5),
            ),
          ]),
        ),
      ),
    );
  }
}
