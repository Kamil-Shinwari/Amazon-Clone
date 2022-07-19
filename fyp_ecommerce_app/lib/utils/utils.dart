import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class utils {
  Size getScreenSize() {
    return MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
  }

  ShowSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }

  Future<Uint8List?> pickImage()  async{
    ImagePicker picker=ImagePicker();
   XFile? file= await picker.pickImage(source: ImageSource.gallery);
    return file!.readAsBytes();
   
  }
  String getUid(){
    return (100000 + Random().nextInt(100000)).toString();
  }
}


