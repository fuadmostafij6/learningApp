
import 'package:flutter/material.dart';
import 'package:learningapp/constant/rout_page.dart';
import 'package:learningapp/screen/auth/registerdPage.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../../controllar/google_provider.dart';
import '../BottomNav.dart';

bool _wrongEmail = false;
bool _wrongPassword = false;



// ignore: must_be_immutable
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  bool _showSpinner = false;




  String emailText = 'Email doesn\'t match';
  String passwordText = 'Password doesn\'t match';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/images/background.png'),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 60.0, bottom: 20.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 50.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'please login',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Text(
                      'to your account',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        labelText: 'Email',
                        errorText: _wrongEmail ? emailText : null,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Password',
                        errorText: _wrongPassword ? passwordText : null,
                      ),
                    ),

                  ],
                ),
                InkWell(
                  onTap: () async {

                    try {
                      setState(() {
                        _showSpinner = true;
                      });
                      setState(() {
                        _wrongEmail = false;
                        _wrongPassword = false;
                      });
                      final newUser = await Googlehelper.firebaseAuth.signInWithEmailAndPassword(
                          email: email!, password: password!);
                      if (newUser != null) {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BNB()), (route) => false);
                        setState(() {
                          _showSpinner = false;
                        });
                      }
                    } catch (e) {
                      setState(() {
                        _showSpinner = false;
                      });
                      print(e);
                      if (e == 'ERROR_WRONG_PASSWORD') {
                        setState(() {
                          _wrongPassword = true;
                        });
                      } else {
                        setState(() {
                          emailText = 'User doesn\'t exist';
                          passwordText = 'Please check your email';

                          _wrongPassword = true;
                          _wrongEmail = true;
                        });
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),

                    decoration: BoxDecoration(
                      color: Color(0xff447def),
                      borderRadius: BorderRadius.circular(8)
                    ),

                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 60.0,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      'Or',
                      style: TextStyle(fontSize: 25.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: 60.0,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Consumer<GoogleLogin>(builder: ((context, value, child) {

                  return

                    Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20),
                      child: InkWell(
                        onTap: (){
                          value.login(context);
                        },
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.blue)

                            ),
                            child:
                            value.loading?Center(child: CircularProgressIndicator(),):
                            value.loading
                                ? Center(
                              child: CircularProgressIndicator(),
                            )
                                :  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(image:AssetImage("image/googleimage.png",),height: 50,width: 50,),
                                Text('Login',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              ],
                            )




                        ),
                      ),
                    );
                })),
                // Row(
                //   children: [
                //
                //
                //   ],
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                      },
                      child: Text(
                        ' Sign Up',
                        style: TextStyle(fontSize: 15.0, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}