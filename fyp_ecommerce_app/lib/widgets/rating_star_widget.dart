import 'package:flutter/material.dart';

class RatingStarWidget extends StatelessWidget {
  final int rating;
  const RatingStarWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < 5; i++) {
      children.add(i < rating
          ? Icon(Icons.star, color: Colors.orange,size: 20,)
          : Icon(
              Icons.star_outline_outlined,
              color: Colors.orange,
              size: 20,
            ));
    }
    return Row(
      children: children,
    );
  }
}
