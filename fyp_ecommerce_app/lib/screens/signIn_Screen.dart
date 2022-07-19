import 'package:flutter/material.dart';
import 'package:fyp_ecommerce_app/resources/authentication.dart';
import 'package:fyp_ecommerce_app/screens/home.dart';
import 'package:fyp_ecommerce_app/screens/signUpScree.dart';
import 'package:fyp_ecommerce_app/utils/color_themes.dart';
import 'package:fyp_ecommerce_app/utils/constants.dart';
import 'package:fyp_ecommerce_app/utils/utils.dart';
import 'package:fyp_ecommerce_app/widgets/custom_mainButton.dart';
import 'package:fyp_ecommerce_app/widgets/textfield_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    AuthenticationMethods authenticationMethods=AuthenticationMethods();
    dispose() {
      emailcontroller.dispose();
      passwordcontroller.dispose();
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: screenSize.height * 0.6,
                      width: screenSize.width * 0.8,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign-In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
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
                                child: Text('Sign-In',style: TextStyle(color: Colors.black),),
                                color: yellowColor,
                                isloading: true,
                                onPressed: () async{
                                String output=await authenticationMethods.SignInUser(email: emailcontroller.text, password: passwordcontroller.text);
                              setState(() {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Homepage(),));
                              });
                               if(output =="success"){
                               
                               }else{
                                utils().ShowSnackBar(context: context, content: output);
                               }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                 
                  Row(children: [
                    Expanded(child: Container(height: 2,color: Colors.grey,)),
                    Text('New To Amazon?'),
                    Expanded(child: Container(height: 2,color: Colors.grey,)),
                  ],),
                 
                  MainCustomButton(child: Text('Create Amazon Account',style: TextStyle(color: Colors.black),),
                   color: Colors.grey[500]!, 
                   isloading: true, 
                   onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen(),));
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
