



import 'package:flutter/material.dart';

import '../service/google_service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ListView(

      children: [
        CircleAvatar(
          radius: 90,
          backgroundColor: Colors.black,
          child: CircleAvatar(
            radius: 80,
            backgroundImage:
            NetworkImage(Googlehelper.firebaseAuth.currentUser!.photoURL!),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name", style: TextStyle(
                    fontSize: 15
                  ),),
                  Text(Googlehelper.firebaseAuth.currentUser!.email!, style: TextStyle(
                    fontSize: 20
                  ),),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email",style: TextStyle(
                      fontSize: 15
                  )),
                  Text(Googlehelper.firebaseAuth.currentUser!.email!,style: TextStyle(
                      fontSize: 20
                  )),
                ],
              ),

              Googlehelper.firebaseAuth.currentUser!.phoneNumber!=null?    Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone Number",style: TextStyle(
                      fontSize: 15
                  )),
                  Text(Googlehelper.firebaseAuth.currentUser!.phoneNumber!,style: TextStyle(
                      fontSize: 20
                  )),
                ],
              ):Container(),
            ],
          ),
        ),



      ],
    );
  }
}
