
import 'package:flutter/material.dart';
import 'package:learningapp/constant/rout_page.dart';
import 'package:learningapp/screen/homescreen.dart';
// import '../Constant/pageRout.dart';
// import '../Services/GoogleServices.dart';
// import '../page/Call_Ganerate_screen/call_genaret_screen.dart';
import '../service/google_service.dart';

class GoogleLogin extends ChangeNotifier{

  login(BuildContext context)async{
    final user =await Googlehelper().signInWithGoogle(context);

    if(user!=null){
      NewPageRout.newPage(context, const HomePage());
    }
  }

}