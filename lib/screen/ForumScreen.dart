


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/Announcment.dart';
import 'package:learningapp/screen/Feed.dart';
import 'package:learningapp/service/google_service.dart';

import '../constant/rout_page.dart';
import 'Question.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  var selectedIndex = 0;
TextEditingController postController = TextEditingController();


Post(String type)async{
  var docs = DateTime.now().microsecondsSinceEpoch;
  await Googlehelper.FireBaseStore.collection("Post").doc(docs.toString()).set({
    "Post": postController.text,
    "time":DateTime.now().toString(),
    "type":type,
    "post_id": docs.toString(),
    "user_id":Googlehelper.firebaseAuth.currentUser!.uid,
    "user_name":Googlehelper.firebaseAuth.currentUser!.displayName,
    "user_image":Googlehelper.firebaseAuth.currentUser!.photoURL,
  });
}

@override
  void dispose() {
  postController.clear();
    super.dispose();
  }

  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  var Pages=[
    Feed(),
    Announcement(),
    Question()
  ];

  Future<void> _showAlertDialog(String data,) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog( // <-- SEE HERE
          title:  Text('Post Your $data'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                TextFormField(
                  controller: postController,
                ),
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(
                          8.0)
                  ),
                  child: InkWell(


                    onTap: () {
                      Post(data);
Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 15,),
                        Icon(Icons.edit, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text("Post",style: TextStyle(
                            color: Colors.white
                        ),),
                        SizedBox(width: 5,),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          actions: <Widget>[


          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final tabBarList=["Feed", "Announcement", "Question"];
    return Scaffold(
      appBar:   PreferredSize(
        preferredSize: AppBar().preferredSize,
        child:
        NewAppBar.buildAppBar(name: "Forum", ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.black,
            borderRadius: BorderRadius.circular(
                8.0)
        ),
        child: InkWell(


          onTap: () {
            _showAlertDialog(selectedIndex==0?"Feed": selectedIndex==1?"Announcement":"Question");
          },
          child: Row(
            children: [
              SizedBox(width: 5,),
              Icon(Icons.edit, color: Colors.white,),
              SizedBox(width: 5,),
              Text("Post",style: TextStyle(
                color: Colors.white
              ),),
              SizedBox(width: 5,),
            ],
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 15,),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: tabBarList.length,
                itemBuilder: (context, index){

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      changeIndex(index);
                    },
                    child: Container(


                      decoration: BoxDecoration(
                        color:selectedIndex!=index?
                        Colors.grey.withOpacity(0.2):Colors.black,

                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 5,),
                         index==0? Icon(Icons.list_alt,color: selectedIndex==index?Colors.white: Colors.black): index==1?Icon(Icons.mic_external_on,color: selectedIndex==index?Colors.white: Colors.black):Icon(Icons.question_mark,color: selectedIndex==index?Colors.white: Colors.black),
                      SizedBox(width: 5,),
                      Text(tabBarList[index], style: TextStyle(
                        fontSize: 16,
                        color: selectedIndex==index?Colors.white: Colors.black
                      ),

                      overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                          SizedBox(width: 5,),
                        ],
                      ),
                    ),
                  ),
                );

            }),
          ),

          AnimatedSwitcher(duration: Duration(
            seconds: 1
          ),

            child: Pages[selectedIndex] ,
          )



        ],
      ),

    );
  }
}
