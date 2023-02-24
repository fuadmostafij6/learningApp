



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/google_service.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  FirebaseAuth auth=FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:FirebaseFirestore.instance.collection("user").snapshots() ,
      builder:(context,snapshot){
        return  ListView.builder(
            itemCount: snapshot.data!.docs.length,
            primary: false,
            shrinkWrap: true,
            itemBuilder: (context,index){
              QueryDocumentSnapshot document=snapshot.data!.docs[index];
              return  auth.currentUser!.uid==document["uid"]?
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                     children: [

                       Container(
                         height:MediaQuery.of(context).size.height/4 ,
                         decoration: BoxDecoration(
                             color: Colors.greenAccent,
                             borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15),
                             )
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 15,left: 145),
                         child: Text("${document["full_name"]}",style: TextStyle(
                             fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white
                         ),),
                       ),
                       Padding(
                         padding: const EdgeInsets.only(top: 70,left: 100),
                         child: CircleAvatar(
                           radius: 70,
                           backgroundImage: NetworkImage("${document["image"]}"),
                         ),
                       ),
                     ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15,left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name : ${document["full_name"]}",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black
                          ),),
                          SizedBox(height: 10,),
                          Text("Name : ${document["phone"]}",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black
                          ),),
                          SizedBox(height: 10,),
                          Text("Name : ${document["email"]}",style: TextStyle(
                              fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black
                          ),),
                          SizedBox(height: 10,),

                        ],
                      ),
                    )
                  ],
                ),
              ):Container();
            });
      },
    );
      
    //   Column(
    //   children: [
    //   CircleAvatar(
    //     radius: 70,
    //     backgroundImage: NetworkImage(""),
    //   )
    //   ],
    // );
  }


  // ListView(
  // children: [
  // CircleAvatar(
  // radius: 90,
  // backgroundColor: Colors.black,
  // child: CircleAvatar(
  // radius: 80,
  // backgroundImage:
  // NetworkImage(Googlehelper.firebaseAuth.currentUser!.photoURL!),
  // ),
  // ),
  //
  // Padding(
  // padding: const EdgeInsets.all(15.0),
  // child: Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Text("Name", style: TextStyle(
  // fontSize: 15
  // ),),
  // Text(Googlehelper.firebaseAuth.currentUser!.email!, style: TextStyle(
  // fontSize: 20
  // ),),
  // ],
  // ),
  // Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Text("Email",style: TextStyle(
  // fontSize: 15
  // )),
  // Text(Googlehelper.firebaseAuth.currentUser!.email!,style: TextStyle(
  // fontSize: 20
  // )),
  // ],
  // ),
  //
  // Googlehelper.firebaseAuth.currentUser!.phoneNumber!=null?    Column(
  // mainAxisAlignment: MainAxisAlignment.center,
  // crossAxisAlignment: CrossAxisAlignment.start,
  // children: [
  // Text("Phone Number",style: TextStyle(
  // fontSize: 15
  // )),
  // Text(Googlehelper.firebaseAuth.currentUser!.phoneNumber!,style: TextStyle(
  // fontSize: 20
  // )),
  // ],
  // ):Container(),
  // ],
  // ),
  // ),
  //
  //
  //
  // ],
  // )
}
