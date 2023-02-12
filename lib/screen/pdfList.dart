


import 'package:flutter/material.dart';

class PdfList extends StatelessWidget {
  final Map bookList;
  final String image;
  final String name;

  const PdfList({Key? key, required this.bookList,required this.image, required this.name}) : super(key: key);
///gwgw
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),

      body:
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height/4.5,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(image),fit: BoxFit.fill),

                ),

              ),
              SizedBox(height: 15,),
              ListView.builder(
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

            ],
          )




    );
  }
}

