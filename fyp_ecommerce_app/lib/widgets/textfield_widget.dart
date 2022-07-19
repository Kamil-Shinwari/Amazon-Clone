import 'package:flutter/material.dart';
class TextFieldWidget extends StatefulWidget {
 final String title;
 final String hinttext;
 final TextEditingController editingController;
 final bool obsecureText;
  TextFieldWidget({required this.hinttext,required this.title,required this.editingController,required this.obsecureText});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
 late FocusNode focusNode;
 bool isfocus=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode=FocusNode();
    focusNode.addListener(() { 
      if(focusNode.hasFocus){
        setState(() {
          isfocus=true;
        });
      }else{
        setState(() {
          isfocus=false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom:8.0),
          child: Text(widget.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
           isfocus? BoxShadow(
              color: Colors.orange,
              blurRadius: 6,
              spreadRadius: 2,

            ):BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 6,
              spreadRadius: 2,

            )
          ]),
          child: TextField(
            focusNode: focusNode,
            controller: widget.editingController,
            decoration: InputDecoration(fillColor: Colors.white,filled: true,focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.orange,width: 1),borderRadius: BorderRadius.circular(4),) ,hintText: widget.hinttext,border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,width: 1),borderRadius: BorderRadius.circular(4),),),
          obscureText: widget.obsecureText,
          maxLines: 1,
          
          ),
        ),
      ],);
  }
}