import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/widgets/categories_more_widgets.dart';
import 'package:fyp_ecommerce_app/widgets/searchbar_widget.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isreadOnly: true,
        hasBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
            itemCount: categoryLogos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.2 / 3.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) => CategoriesMoreWidget(index: index)),
      ),
    );
  }
}
