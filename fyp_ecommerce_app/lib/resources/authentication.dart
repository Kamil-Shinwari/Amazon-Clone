import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_ecommerce_app/models/user_detail_model.dart';
import 'package:fyp_ecommerce_app/resources/cloudfirestore.dart';

class AuthenticationMethods{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  CloudFirestoreClass cloudFirestoreClass= CloudFirestoreClass();
  Future<String> SignUpuser({required String name,required String address,required String email,required String password})async{
      name.trim();
      address.trim();
      email.trim();
      password.trim();
      String output="some error occured";
      if(name !=" " && address !="" && password !="" && email != ""){
        
        try{
          firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
          UserModel user=UserModel(name: name, address: address);
          await cloudFirestoreClass.uploadNameAndAddressToDatabase(model: user);
          output="success";
        }on FirebaseAuthException catch(e){
          output=e.message.toString();
        }
      }
      else{
        output="plz fill all field";
      }
      return output;
  }


   Future<String> SignInUser({required String email,required String password})async{
     
      email.trim();
      password.trim();
      String output="some error occured";
      if( password !="" && email != ""){
        
        try{
          firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
          output="success";
        }on FirebaseAuthException catch(e){
          output=e.message.toString();
        }
      }
      else{
        output="plz fill all field";
      }
      return output;
  }
}