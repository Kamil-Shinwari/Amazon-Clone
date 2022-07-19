import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';
import 'package:fyp_ecommerce_app/screens/signIn_Screen.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/widgets/Product_showCase_list_view.dart';
import 'package:fyp_ecommerce_app/widgets/banner_ads_widget.dart';
import 'package:fyp_ecommerce_app/widgets/categorize_horizental_list_bar.dart';
import 'package:fyp_ecommerce_app/widgets/loading_widget.dart';
import 'package:fyp_ecommerce_app/widgets/searchbar_widget.dart';
import 'package:fyp_ecommerce_app/widgets/simpleProductwidget.dart';
import 'package:fyp_ecommerce_app/widgets/user_details_bar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ScrollController controller=ScrollController();
  double offset=0;
  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdate();
    controller.addListener(() { 
      setState(() {
        offset=controller.position.pixels;
      });
    });
  }
  void getdate() async{
    List<Widget> temp70= await CloudFirestoreClass().getProductFromDiscount(70);
    List<Widget> temp60= await CloudFirestoreClass().getProductFromDiscount(60);
    List<Widget> temp50=await CloudFirestoreClass().getProductFromDiscount(50);
    List<Widget> temp0=await CloudFirestoreClass().getProductFromDiscount(0);
    setState(() {
      discount70=temp70;
      discount60=temp60;
      discount50=temp50;
      discount0=temp0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isreadOnly: true,
        hasBackButton: false,
      ),
      body: discount70!=null && discount60 !=null && discount50 !=null && discount0 !=null? Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Column(children: [
              SizedBox(height: kAppBarHeight/2,),
            CategoriesHorizentallListBarView(),
            BannerAdsWidget(),
            ProductShowCaseListView(title: "upto 70% off", children: discount70!),
              ProductShowCaseListView(title: "upto 60% off", children: discount60!,),
              ProductShowCaseListView(title: "upto 50% off", children: discount50!,),
             ProductShowCaseListView(title: "Explore", children: discount0!,),
          ]),),
        UserDetailBar(offset: offset,),
        ],
      )
      :LoadinWidget(),
      
    );
  }
}
