import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/controllar/google_provider.dart';
import 'package:learningapp/screen/auth/google_loginpage.dart';
import 'package:learningapp/screen/homescreen.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:provider/provider.dart';

import 'controllar/BookListProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => GoogleLogin())),
      ChangeNotifierProvider(create: ((context) => BookListProvider())),

    ],

  child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,



      ),
      home:
      Googlehelper.firebaseAuth.currentUser ==null?
      GoogleLoginScreen(): HomePage(),

    );
  }
}

