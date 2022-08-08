import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/resources/authentication.dart';
import 'package:fyp_ecommerce_app/screens/signIn_Screen.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';

import '../utils/constants.dart';
import '../utils/utils.dart';
import '../widgets/custom_mainButton.dart';
import '../widgets/textfield_widget.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
      TextEditingController namecontroller = TextEditingController();
    TextEditingController emailcontroller = TextEditingController();
      TextEditingController addresscontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    AuthenticationMethods authenticationMethods=AuthenticationMethods();
    dispose() {
      emailcontroller.dispose();
      passwordcontroller.dispose();
      namecontroller.dispose();
      addresscontroller.dispose();
    }

    Size screenSize = utils().getScreenSize();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    height: screenSize.height * 0.10,
                  ),
                  SizedBox(
                    height: screenSize.height *0.7,
                    width: screenSize.width * 0.9,
                    child: FittedBox(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                        height: screenSize.height * 0.8,
                        width: screenSize.width * 0.9,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sign-Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                             TextFieldWidget(
                                hinttext: "Enter an Name",
                                title: 'Name',
                                editingController: namecontroller,
                                obsecureText: false),
                                 TextFieldWidget(
                                hinttext: "Enter an Address",
                                title: 'Address',
                                editingController: addresscontroller,
                                obsecureText: false),
                            TextFieldWidget(
                                hinttext: "Enter an Email",
                                title: 'Email',
                                editingController: emailcontroller,
                                obsecureText: false),
                            TextFieldWidget(
                                hinttext: "Enter an password",
                                title: 'password',
                                editingController: passwordcontroller,
                                obsecureText: true),
                            Align(
                              alignment: Alignment.center,
                              child: MainCustomButton(
                                  child: Text('Sign-Up',style: TextStyle(color: Colors.black),),
                                  color: yellowColor,
                                  isloading: true,
                                  onPressed: ()async {
                                   String output= await authenticationMethods.SignUpuser(
                                      name: namecontroller.text, 
                                    address: addresscontroller.text, 
                                    email: emailcontroller.text,
                                     password: passwordcontroller.text);
                                     if(output=="success"){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
                                     }else{
                                      utils().ShowSnackBar(context: context, content: output);
                                     }
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 
                
                 
                  MainCustomButton(child: Text('Back',style: TextStyle(color: Colors.black),),
                   color: Colors.grey[500]!, 
                   isloading: true, 
                   onPressed: (){
                   Navigator.pop(context);
                   })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
