import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/screens/result_screen.dart';
import 'package:fyp_ecommerce_app/screens/search_screen.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';

class SearchBarWidget extends StatelessWidget with PreferredSizeWidget {
  final bool isreadOnly;
  final bool hasBackButton;
  SearchBarWidget(
      {Key? key, required this.isreadOnly, required this.hasBackButton})
      : super(key: key);
  @override
  @override
  Widget build(BuildContext context) {
    Size Screensize = utils().getScreenSize();
    OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey, width: 1),
    );
    return SafeArea(
      child: Container(
        height: kAppBarHeight,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: backgroundGradient,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          hasBackButton
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back))
              : Container(),
          SizedBox(
            width: Screensize.width * 0.7,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 5))
              ]),
              child: TextField(
                onSubmitted: (String query) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(query: query),
                      ));
                },
                readOnly: isreadOnly,
                onTap: () {
                  if (isreadOnly) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SearchScreen(),
                        ));
                  }
                },
                decoration: InputDecoration(
                  hintText: "Search anyThing Here",
                  fillColor: Colors.white,
                  filled: true,
                  border: border,
                  focusedBorder: border,
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.mic_none_outlined))
        ]),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return Size.fromHeight(kAppBarHeight);
  }
}
