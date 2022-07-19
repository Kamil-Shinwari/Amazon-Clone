import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';

import '../utils/color_themes.dart';
class AccountScrenAppBar extends StatelessWidget with PreferredSizeWidget{
  final Size preferredSize;
 const AccountScrenAppBar({Key? key}) :preferredSize=const Size.fromHeight(kAppBarHeight), super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize=utils().getScreenSize();
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        width: screensize.width,
        decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: backgroundGradient,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:15.0),
                        child: Image.network(amazonLogoUrl,height: kAppBarHeight*0.7,),
                      ),

                      Row(children: [
                        IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined,color: Colors.black,),),
                        IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined,color: Colors.black,))
                      ],)
                  ]),
      ),
    );
  }
}