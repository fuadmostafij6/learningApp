
import 'package:flutter/material.dart';
import 'package:learningapp/constant/rout_page.dart';
import 'package:learningapp/screen/homescreen.dart';
// import '../Constant/pageRout.dart';
// import '../Services/GoogleServices.dart';
// import '../page/Call_Ganerate_screen/call_genaret_screen.dart';
import '../screen/BottomNav.dart';
import '../service/google_service.dart';

class GoogleLogin extends ChangeNotifier{

  bool loading = false;
  postUserData(uuid, name, email, phone, image){
    //var doc = DateTime.now().microsecondsSinceEpoch.toString();
    Googlehelper.FireBaseStore.collection("user").doc(uuid).set({
      "uid":"${uuid}",
      "full_name":"${name}",
      "image":"${image}",
      "email":"${email}",
      "phone":"${phone}"
    });
  }
  login(BuildContext context)async{
    loading=true;
    notifyListeners();
    final user =await Googlehelper().signInWithGoogle(context);
//
    if(user!=null){
      postUserData(user.user!.uid,user.user!.displayName,user.user!.email,user.user!.phoneNumber,user.user!.photoURL, );
      // NewPageRout.newPage(context, const HomePage());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (c)=>BNB()), (route) => false);
      loading=false;
      notifyListeners();
    }

  }

}