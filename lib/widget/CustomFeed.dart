

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/widget/postWidget.dart';

import '../service/google_service.dart';

Widget customFeed(String type) {
  return Column(
    children: [
      StreamBuilder<QuerySnapshot>(
          stream:Googlehelper.FireBaseStore.collection("Post").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, ) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }
            else if(!snapshot.hasData){
              return Center(
                child: Text("Data Not Found"),
              );}
            else if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                var data=snapshot.data!.docs[index];

                return

                  type== data["type"]?
                  Padding(
                    padding: const EdgeInsets.only(top: 6,bottom: 6),
                    child: PostWidget(
                      displayName:data["user_name"],
                      image:data["user_image"],
                      postText: data["Post"],
                      commentLength:data["comment_length"],
                      tap: true, id:data["post_id"] ,
                    ),
                  ):Container();
              },
            );
          }
      )

    ],
  );
}