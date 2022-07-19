import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';

import '../screens/result_screen.dart';

class CategoriesHorizentallListBarView extends StatelessWidget {
  const CategoriesHorizentallListBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight,
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
               Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(query: categoriesList[index])));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
              child: Column(
                
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(categoryLogos[index]),
                  ),
                 
                  Text(categoriesList[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
