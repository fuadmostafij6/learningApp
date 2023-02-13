import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewPageRout{


  static newPage( BuildContext context,Widget child){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>child));
  }
}

class NewAppBar{

 static Widget buildAppBar({required String name, bool? pdf, Function()? function, Function()? function1}) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(name, style: TextStyle(color: Colors.black),),
      centerTitle: true,
      elevation: 0,

      actions:

    pdf !=null?
    <Widget>[
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.black,
          ),
          onPressed:function,
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black,
          ),
          onPressed: function1,
        )
      ]:null,
      // leading:manu?
      // Icon(Icons.menu, color:Colors.black,size: 25,):null,


    );
  }
}