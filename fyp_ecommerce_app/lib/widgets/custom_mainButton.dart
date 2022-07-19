import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';

class MainCustomButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isloading;
  final VoidCallback onPressed;
  MainCustomButton(
      {required this.child,
      required this.color,
      required this.isloading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = utils().getScreenSize();
    return ElevatedButton(
      onPressed: onPressed,
      child: isloading ? child:Padding(
        padding: const EdgeInsets.symmetric(vertical:4.0),
        child: AspectRatio(aspectRatio: 1/1,child: CircularProgressIndicator(color: Colors.white,)),
      ),
      style: ElevatedButton.styleFrom(
        primary: color,
        fixedSize: Size(screenSize.width * 0.7, 40),
      ),
      
    );
  }
}
