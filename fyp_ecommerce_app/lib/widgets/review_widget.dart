import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/review_model.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/rating_star_widget.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel reviewModel;
  const ReviewWidget({Key? key, required this.reviewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = utils().getScreenSize();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            reviewModel.senderName,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:5.0),
            child: Row(
              children: [
                SizedBox(
                  width: screensize.width / 4,
                  child: FittedBox(
                      child: RatingStarWidget(
                    rating: reviewModel.rating,
                  )),
                ),
                
                
                Padding(
                  padding: const EdgeInsets.only(left:5.0),
                  child: Text(keysOfRating[reviewModel.rating-1]),
                ),
              ],
            ),
          ),
         
          Text(reviewModel.description,maxLines: 3,overflow: TextOverflow.ellipsis,),
          
        ],
      ),
    );
  }
}
