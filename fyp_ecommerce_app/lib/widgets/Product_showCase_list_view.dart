import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';

class ProductShowCaseListView extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductShowCaseListView(
      {Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = utils().getScreenSize();
    double height = screensize.height / 5;
    double titleheight = 25;
    return Container(
      margin: EdgeInsets.all(8),
      height: height,
      width: screensize.width,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
            height: titleheight,
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    'Show More',
                    style: TextStyle(color: activeCyanColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: height-(titleheight+26),
          width: screensize.width,
          child: ListView(scrollDirection: Axis.horizontal,children: children),),
           
        ]),
      ),
    );
  }
}
