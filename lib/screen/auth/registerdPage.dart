
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learningapp/constant/flutterToast.dart';
import 'package:learningapp/screen/BottomNav.dart';
import 'package:learningapp/screen/auth/loginScreen.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart' as validator;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../controllar/google_provider.dart';
class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var box=Hive.box('user');

  String? name;
  String? email;
  String? password;
  String? phone;

  bool _showSpinner = false;

  bool _wrongEmail = false;
  bool _wrongPassword = false;

  String _emailText = 'Please use a valid email';
  String _passwordText = 'Please use a strong password';


  File ? imagefile;
  ImagePicker imagePicker = ImagePicker();
  String? imagepath;

  void takePhoto (ImageSource source)async{
    final picarimagefile= await imagePicker.getImage(source:source,imageQuality: 80);
    setState(() {
      imagefile= File(picarimagefile!.path);
    });

    Reference reference=FirebaseStorage.instance.ref().child(DateTime.now().toString());

    await reference.putFile(File(imagefile!.path));
    reference.getDownloadURL().then((value){
      setState(() {
        imagepath=value;
        print("Image Link....${imagepath}");
      });

    });

  }


Future postUserData(uuid)async{
    print("post");
    if(imagepath !=null){
      await Googlehelper.FireBaseStore.collection("user").doc(uuid).set({
        "uid":"${uuid}",
        "full_name":"${name}",
        "image":imagepath!,
        "email":"${email}",
        "phone":"${phone}"
      }).then((value){
        print("posted");
      });

      box.put("uid", uuid);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>BNB()), (route) => false);
    }

    else{
      NewFlutterToast.errorToast("Please Provide a image");
    }
  //var doc = DateTime.now().microsecondsSinceEpoch.toString();

  // box.put("name", name);
  // box.put("email", email);
  // box.put('image', imagepath);

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        color: Colors.blueAccent,
        child: SingleChildScrollView(
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
                    // Text(
                    //   'Register',
                    //   style: TextStyle(fontSize: 50.0),
                    // ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       'Lets get',
                    //       style: TextStyle(fontSize: 30.0),
                    //     ),
                    //     Text(
                    //       'you on board',
                    //       style: TextStyle(fontSize: 30.0),
                    //     ),
                    //   ],
                    // ),

                    Stack(
                      alignment: Alignment.center,
                      children: [
                        imagefile !=null?
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage: FileImage(File(imagefile!.path)),
                        ):
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.amberAccent.withOpacity(0.3),),

                        Padding(
                          padding: const EdgeInsets.only(left: 95,top: 35),
                          child: InkWell(
                            onTap: (){

                              showDialog(
                                  context: context,
                                  builder: (_){
                                    return AlertDialog(
                                      title: Text("Upload a Photo"),
                                      content:  Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              onPressed: (){
                                                 takePhoto(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Camera")),
                                          SizedBox(width: 10,),
                                          TextButton(
                                              onPressed: (){
                                                takePhoto(ImageSource.gallery);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Gallery"))
                                        ],
                                      ),
                                    );
                                  });

                            },
                              child: Icon(Icons.camera_alt,size: 30,color: Colors.grey,)),
                        )

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
                           // errorText: _wrongPassword ? _passwordText : null,
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

                            if(imagepath !=null){
                              final newUser = await Googlehelper.firebaseAuth.createUserWithEmailAndPassword(
                                email: email!,
                                password: password!,
                              );

                              print(newUser.user!.uid.isNotEmpty);
                              if (newUser.user!.uid.isNotEmpty){

                                print('user authenticated by registration');

                                await postUserData(newUser.user!.uid).then((value){

                                  setState(() {
                                    _showSpinner = false;
                                  });
                                });


                              }
                            }

                            else{
                              NewFlutterToast.errorToast("Please Provide a image");
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
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

                          },
                          child: Text(
                            ' Sign In',
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
        ),
      ),
    );
  }
}