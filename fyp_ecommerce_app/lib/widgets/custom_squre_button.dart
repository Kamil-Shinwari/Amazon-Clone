import 'package:flutter/material.dart';

class CustomSqureButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onpressed;
  final Color color;
  final double dimension;
  const CustomSqureButton(
      {Key? key,
      required this.child,
      required this.onpressed,
      required this.color,
      required this.dimension})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: dimension,
        width: dimension,
    
        decoration: ShapeDecoration(
            color: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey,width: 1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        child: child,
        
      ),
    );
  }
}
