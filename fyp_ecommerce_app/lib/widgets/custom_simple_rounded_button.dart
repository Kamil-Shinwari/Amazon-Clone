import 'package:flutter/material.dart';
class CustomSimpleRoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onprssed;
  const CustomSimpleRoundedButton({Key? key,required this.text,required this.onprssed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onprssed,
      
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.white,border: Border.all(color:Colors.grey,width: 1),
      ),child: Text("$text"),),
    );
  }
}