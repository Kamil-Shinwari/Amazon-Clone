import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/providers/user_detail_provider.dart';
import 'package:fyp_ecommerce_app/screens/signIn_Screen.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {

  PageController pageController = PageController();
  int currentindex=0;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
  changePage(int page){
            pageController.jumpToPage(page);
            setState(() {
              currentindex=page;
            });
          }
          @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailProvider>(context).getData();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        
        body: PageView(
          
          controller: pageController,
          // ignore: prefer_const_literals_to_create_immutables
          children:screens,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade400,width: 1))),
          child: TabBar(
            indicator: BoxDecoration(border: Border(top: BorderSide(color: activeCyanColor,width: 4))),
            onTap: changePage,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
            Tab(
              child: Icon(Icons.home_outlined,color: currentindex==0?activeCyanColor:Colors.black,),
            ),
            Tab(
              child: Icon(Icons.account_circle_outlined,color: currentindex==1?activeCyanColor:Colors.black),
            ),
            Tab(
              child: Icon(Icons.shopping_cart,color: currentindex==2?activeCyanColor:Colors.black),
            ),
            Tab(
              child: Icon(Icons.menu,color: currentindex==3?activeCyanColor:Colors.black),
            ),
             
          ]),
        ),
      ),
    );
  }
}
