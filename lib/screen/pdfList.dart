


import 'package:flutter/material.dart';

class PdfList extends StatelessWidget {
  final Map bookList;
  const PdfList({Key? key, required this.bookList}) : super(key: key);
///gwgw
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Pdf"),
      ),

      body: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount:bookList.length,

          itemBuilder: (context, index){
            String key = bookList.keys.elementAt(index);

        return ListTile(

          title: Text(key),
          subtitle: Text("${bookList[key]}"),



        );
      }),
    );
  }
}
