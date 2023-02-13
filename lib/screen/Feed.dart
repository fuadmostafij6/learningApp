import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:learningapp/widget/postWidget.dart';

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;

    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream:Googlehelper.FireBaseStore.collection("Post").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, ) {
              if(!snapshot.hasData){
                return Center(
                  child: Text("Loading...."),
                );}
              else if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Text("Loading");
              }
              return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                  var data=snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 6,bottom: 6),
                    child: PostWidget(
                      displayName:data["user_name"],
                      image:data["user_image"],
                      postText: data["Post"],
                      commentLength:data["comment_length"],
                    ),
                  );
                  },
              );
            }
        )
        
      ],
    );
  }
}
