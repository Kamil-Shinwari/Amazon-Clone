import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';

class BannerAdsWidget extends StatefulWidget {
  const BannerAdsWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdsWidget> createState() => _BannerAdsWidgetState();
}

class _BannerAdsWidgetState extends State<BannerAdsWidget> {
  int currentad = 0;


  @override
  Widget build(BuildContext context) {
    Size screensize = utils().getScreenSize();
      double smallAdsheight = screensize.width/4;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (currentad == (largeAds.length - 1)) {
          currentad = -1;
        }
        setState(() {
          currentad++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentad],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screensize.width,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    backgroundColor,
                    backgroundColor.withOpacity(0)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                ),
              )
            ],
          ),
          Container(
            color: backgroundColor,
            width: screensize.width,
            height: smallAdsheight,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                   
                    children: [
                      getsmallAdsFromIndex(0, smallAdsheight),
                      getsmallAdsFromIndex(1, smallAdsheight),
                      getsmallAdsFromIndex(2, smallAdsheight),
                      getsmallAdsFromIndex(3, smallAdsheight),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getsmallAdsFromIndex(int index, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: Container(
        height: height,
        width: height,
        decoration: ShapeDecoration(
            color: Colors.white,
            shadows: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  spreadRadius: 1)
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        child: Center(
          child: Column(
            mainAxisSize:MainAxisSize.min ,
            children: [
            Image.network(smallAds[index]),
            Text(adItemNames[index]),
          ]),
        ),
      ),
    );
  }
}
