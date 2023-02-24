
import 'package:flutter/material.dart';
import 'package:learningapp/screen/BottomNav.dart';
import 'package:learningapp/screen/auth/loginScreen.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../controllar/google_provider.dart';
class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? name;
  String? email;
  String? password;
  String? phone;

  bool _showSpinner = false;

  bool _wrongEmail = false;
  bool _wrongPassword = false;

  String _emailText = 'Please use a valid email';
  String _passwordText = 'Please use a strong password';


postUserData(uuid){
  //var doc = DateTime.now().microsecondsSinceEpoch.toString();
  Googlehelper.FireBaseStore.collection("user").doc(uuid).set({
    "uid":"${uuid}",
    "full_name":"${name}",
    "image":"",
    "email":"${email}",
    "phone":"${phone}"
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: Colors.blueAccent,
        child: Stack(
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
                    'Register',
                    style: TextStyle(fontSize: 50.0),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lets get',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      Text(
                        'you on board',
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Full Name',
                          labelText: 'Full Name',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          errorText: _wrongEmail ? _emailText : null,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          phone = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone',
                         // errorText: _wrongEmail ? _emailText : null,
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
                          labelText: 'Password',
                          errorText: _wrongPassword ? _passwordText : null,
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),

                  InkWell(

                    onTap: () async {
                      setState(() {
                        _wrongEmail = false;
                        _wrongPassword = false;
                      });
                      try {
                        if (validator.isEmail(email!) &
                        validator.isLength(password!, 6)) {
                          setState(() {
                            _showSpinner = true;
                          });
                          final newUser =
                          await Googlehelper.firebaseAuth.createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                          if (newUser != null) {

                            print('user authenticated by registration');
                            postUserData(newUser.user!.uid);
                            setState(() {
                              _showSpinner = false;
                            });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BNB()), (route) => false);
                          }
                        }

                        setState(() {
                          if (!validator.isEmail(email!)) {
                            _wrongEmail = true;
                            setState(() {
                              _showSpinner = false;
                            });
                          } else if (!validator.isLength(password!, 6)) {
                            _wrongPassword = true;
                            setState(() {
                              _showSpinner = false;
                            });
                          } else {
                            _wrongEmail = true;
                            _wrongPassword = true;
                            setState(() {
                              _showSpinner = false;
                            });
                          }
                        });
                      } catch (e) {
                        setState(() {
                          _showSpinner = false;
                        });
                        setState(() {
                          _wrongEmail = true;
                          if (e == 'ERROR_EMAIL_ALREADY_IN_USE') {
                            _emailText =
                            'The email address is already in use by another account';
                          }
                        });
                      }
                    },                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Color(0xff447def),

                      child: Center(
                        child: Text(
                          'Register',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 25.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        },
                        child: Text(
                          ' Sign In',
                          style: TextStyle(fontSize: 25.0, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}