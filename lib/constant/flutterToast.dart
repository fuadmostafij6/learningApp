import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class NewFlutterToast{
   static errorToast(String massages){
     Fluttertoast.showToast(
         msg: massages,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }
   static successToast(String success){
     Fluttertoast.showToast(
         msg: success,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }
}