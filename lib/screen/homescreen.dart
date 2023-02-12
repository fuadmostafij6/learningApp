import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/BookItem.dart';

import '../constant/rout_page.dart';
import '../service/google_service.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Learning Home Page"),
        ),
        body: FutureBuilder(
          future: Googlehelper.FireBaseStore.collection("book").get(),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
if(snapshot.connectionState ==ConnectionState.waiting){
  return Center(child: CircularProgressIndicator(),);
}
          else if (snapshot.hasData) {
            return

              ListView.builder(
                itemCount: snapshot.data!.docs.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document = snapshot.data!.docs[index];
                  return
                    InkWell(
            onTap: (){
              NewPageRout.newPage(context, BookItemList(id:document["id"], name:document["book_name"],));
            },
                      child: Column(
                        children: [
                          Container(
                            child: Text(document["book_name"].toString()),
                          ),
                          Container(
                            child: Text(document["id"].toString()),
                          ),
                          Container(
                            child: Text(document["image"].toString()),
                          ),
                        ],
                      ),
                    );
                });
          } else {
            return Center(child: Text("No Data"));
          }
        },
        )
    );
  }
}
