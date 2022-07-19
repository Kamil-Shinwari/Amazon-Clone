import 'dart:ui';

import 'package:flutter/material.dart';

class CostWidget extends StatelessWidget {
  final Color color;
  final double cost;
   CostWidget({Key? key, required this.color, required this.cost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            "₹",
            style: TextStyle(
                color: color,
                fontSize: 20,
                fontFeatures: [FontFeature.superscripts()]),
          ),
        ),
        Expanded(
          child: Text(
            cost.toInt().toString(),
            style: TextStyle(
                color: color, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Text(
            (cost - cost.toInt()).toString().substring(0, 6),
            style: TextStyle(
                color: color,
                fontSize: 10,
                fontFeatures: [const FontFeature.superscripts()]),
          ),
        ),
      ],
    );
  }
}
