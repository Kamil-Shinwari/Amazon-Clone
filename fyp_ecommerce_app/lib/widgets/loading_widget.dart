import 'package:flutter/material.dart';
class LoadinWidget extends StatelessWidget {
  const LoadinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(),);
  }
}