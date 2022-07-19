import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/widgets/searchbar_widget.dart';
class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isreadOnly: false,hasBackButton: true,),
    );
  }
}