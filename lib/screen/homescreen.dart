import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/BookItem.dart';
import 'package:learningapp/widget/books_containar.dart';

import '../constant/rout_page.dart';
import '../service/google_service.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white60,
         leading: Icon(Icons.menu,size: 25,),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Icon(Icons.search,size: 30,),
            ),
          ],
        ),
        body: FutureBuilder(
           future: Googlehelper.FireBaseStore.collection("book").get(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);}
          else if (snapshot.hasData) {
            return GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 3,
                   childAspectRatio:0.8
                ),
                itemBuilder: (BuildContext context, int index){
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10,right: 7,top: 8),
                    child: InkWell(
                      onTap: (){
                        NewPageRout.newPage(context, BookItemList(id:data["id"], name:data["book_name"],images: data["image"].toString()));
                      },
                      child: BooksContainar(
                          name: data["book_name"].toString(),
                          image: data["image"].toString()),

                    ),
                  );
                }
            );

          } else {
            return Center(child: Text("No Data"));
          }
        },
        )
    );

  }
}
//ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 primary: false,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   QueryDocumentSnapshot document = snapshot.data!.docs[index];
//                   return
//                     InkWell(
//             onTap: (){
//               NewPageRout.newPage(context, BookItemList(id:document["id"], name:document["book_name"],));
//             },
//                       child: Column(
//                         children: [
//                           Container(
//                             child: Text(document["book_name"].toString()),
//                           ),
//                           Container(
//                             child: Text(document["id"].toString()),
//                           ),
//                           Container(
//                             child: Text(document["image"].toString()),
//                           ),
//                         ],
//                       ),
//                     );
//                 });
