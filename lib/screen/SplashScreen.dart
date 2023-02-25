

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../service/google_service.dart';
import 'BottomNav.dart';
import 'auth/loginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
  Future.delayed(Duration(seconds: 5),(){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>   Googlehelper.firebaseAuth.currentUser ==null?
  LoginPage(): BNB(),), (route) => false);
});
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/background.png'),
          ),

         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Lottie.asset(
               'assets/images/99349-girl-with-books.json',
               width: 200,
               height: 200,
               fit: BoxFit.fill,
             ),
             SizedBox(height: 20,),
             Text("Learning Mate", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
           ],
         )
        ],
      ),
    );
  }
}
