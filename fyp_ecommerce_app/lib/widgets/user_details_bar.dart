import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/providers/user_detail_provider.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:provider/provider.dart';

class UserDetailBar extends StatelessWidget {
  final double offset;
 
  const UserDetailBar({
    Key? key,
    required this.offset,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size Screensize = utils().getScreenSize();
   UserModel userModel=Provider.of<UserDetailProvider>(context).userModel;
    return Positioned(
      top: -offset/5,
      child: Container(
        height: kAppBarHeight / 2,
        width: Screensize.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: lightBackgroundaGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          child: Row(children: [
            Icon(
              Icons.location_on_outlined,
              color: Colors.grey.shade900,
            ),
            SizedBox(
              width: Screensize.width * 0.7,
              child: Text(
                'Deliver to ${userModel.name} - ${userModel.address}',
                style: TextStyle(color: Colors.grey.shade900),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
