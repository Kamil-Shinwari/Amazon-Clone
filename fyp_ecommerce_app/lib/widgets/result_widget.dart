import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/rating_star_widget.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel model;
  const ResultWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size ScreenSize = utils().getScreenSize();
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          SizedBox(
            width: ScreenSize.width / 2,
            child: Image.network(model.url),
          ),
          Text(model.productName,maxLines: 3,overflow: TextOverflow.ellipsis,),
          Row(
            children: [
              RatingStarWidget(rating: model.rating),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              model.cost.toString(),
              style: TextStyle(color: Color.fromARGB(255, 92, 9, 3)),
            ),
          )
        ],
      ),
    );
  }
}
