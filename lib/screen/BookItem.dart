import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/pdfList.dart';

import '../constant/rout_page.dart';
import '../service/google_service.dart';

class BookItemList extends StatelessWidget {
  final id;
  final name;
  const BookItemList({Key? key, this.id, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document = snapshot.data!.docs[index];

                  Map pointlist = Map.from(document["book_list"]);

                  return InkWell(
                    onTap: () {
                      NewPageRout.newPage(
                          context,
                          PdfList(
                            bookList: pointlist,
                          ));
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Text(document["book_item"].toString()),
                        ),
                        Container(
                          child: Text(pointlist.toString()),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}
