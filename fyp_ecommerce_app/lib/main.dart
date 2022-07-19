import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/layout/screen_layout.dart';
import 'package:fyp_ecommerce_app/models/product_model.dart';
import 'package:fyp_ecommerce_app/providers/user_detail_provider.dart';
import 'package:fyp_ecommerce_app/screens/home.dart';
import 'package:fyp_ecommerce_app/screens/product_explaination_screen.dart';
import 'package:fyp_ecommerce_app/screens/result_screen.dart';
import 'package:fyp_ecommerce_app/screens/sell_screen.dart';

import 'package:fyp_ecommerce_app/screens/signIn_Screen.dart';
import 'package:fyp_ecommerce_app/screens/signUpScree.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC-sfSFoKegtOyv1BWLPfJ0SylMnSaC7BY",
            authDomain: "fyp-project-319fd.firebaseapp.com",
            projectId: "fyp-project-319fd",
            storageBucket: "fyp-project-319fd.appspot.com",
            messagingSenderId: "906945876949",
            appId: "1:906945876949:web:2fe3c9a4654b3a516aa35c"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(AmazonClone());
}

class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserDetailProvider(),),
      ],
      child: MaterialApp(
        title: 'Amazon Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.hasData) {
                return ScreenLayout();
                // return SellScreen();
               
              } else {
                return SignInScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
