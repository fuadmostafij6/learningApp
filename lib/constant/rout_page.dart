import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPageRout{


  static newPage( BuildContext context,Widget child){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>child));
  }
}