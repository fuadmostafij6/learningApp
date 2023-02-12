import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/pdfList.dart';

import '../constant/rout_page.dart';
import '../service/google_service.dart';
import '../widget/books_containar.dart';

class BookItemList extends StatelessWidget {
  final id;
  final name;
  final images;
  const BookItemList({Key? key, this.id, this.name,this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: FutureBuilder(
        future: Googlehelper.FireBaseStore.collection("book")
            .doc(id.toString())
            .collection(name.toString())
            .get(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.9
                ),
                itemBuilder: (BuildContext context, int index){
                   DocumentSnapshot data = snapshot.data!.docs[index];
                  return InkWell(
                    onTap: (){
                       NewPageRout.newPage(context, PdfList(bookList:data["book_list"],
                         image: images.toString(),
                         name: data["book_item"].toString(),));
                    },
                    child: BooksContainar(
                        name: data["book_item"].toString(),
                        image: images.toString()),
                  );
                }
            );



          } else {
            return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}

// ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 primary: false,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   QueryDocumentSnapshot document = snapshot.data!.docs[index];
//                   Map pointlist = Map.from(document["book_list"]);
//
//                   return InkWell(
//                     onTap: () {
//                       NewPageRout.newPage(
//                           context,
//                           PdfList(
//                             bookList: pointlist,
//                           ));
//                     },
//                     child: Column(
//                       children: [
//                         Container(
//                           child: Text(document["book_item"].toString()),
//                         ),
//                         Container(
//                           child: Text(pointlist.toString()),
//                         ),
//                       ],
//                     ),
//                   );
//                 });
