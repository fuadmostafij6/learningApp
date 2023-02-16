

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constant/rout_page.dart';
import '../service/google_service.dart';
import '../widget/postWidget.dart';

class PostDetails extends StatefulWidget {
  final String id;



  const PostDetails({Key? key, required this.id,}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.clear();
    super.dispose();
  }

  updateCommentCount(String length)async{
    Googlehelper.FireBaseStore.collection('Post').doc(widget.id).update({
"comment_length":length
    });
  }

  Future comment() async{
    var docs = DateTime.now().microsecondsSinceEpoch;
    Googlehelper.FireBaseStore.collection('Post').doc(widget.id).collection("Comment").doc(docs.toString()).set({

      "comment_id": docs.toString(),
      "comment": commentController.text,
      "user_id": Googlehelper.firebaseAuth.currentUser!.uid,
      "user_name": Googlehelper.firebaseAuth.currentUser!.displayName,
      "user_image": Googlehelper.firebaseAuth.currentUser!.photoURL,

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: NewAppBar.buildAppBar(
          name: "Post Details",
        ),


      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,bottom: 8),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width*0.8,
                child: TextFormField(
                  controller:commentController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'write your comment',
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color:Colors.grey.withOpacity(0.2))
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(
                            color: Colors.black,
                            width: 1
                        )
                    ),
                  ),

                ),
              ),
            ),
            SizedBox(width: 4,),

            InkWell(
                onTap: (){
                  comment().then((value){
                    commentController.clear();
                  });

                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    height: 50,width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.indigo.withOpacity(0.2)
                      ),
                      child: Center(child: Icon(Icons.send_rounded))),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: Googlehelper.FireBaseStore.collection('Post').doc(widget.id).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("No data");
              }
              var data = snapshot.data!;
              return
                PostWidget(
                  displayName:data["user_name"],
                  image:data["user_image"],
                  postText: data["Post"],
                  commentLength:data["comment_length"],
                 id:data["post_id"] ,
                );
            }
    ),
              SizedBox(height: 15,),
              Text("Comment"),


              StreamBuilder<QuerySnapshot>(
                  stream:Googlehelper.FireBaseStore.collection("Post").doc(widget.id).collection("Comment").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, ) {


                    if(!snapshot.hasData){
                      return Center(
                        child: Text("Data Not Found"),
                      );}
                    else if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    }

                    updateCommentCount(snapshot.data!.docs.length.toString());

                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        var data=snapshot.data!.docs[index];

                        return Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Container(
                            child:Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundImage:NetworkImage(data["user_image"]),
                                ),
                                SizedBox(width: 8,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:BorderRadius.circular(12),
                                    color: Colors.grey.withOpacity(0.2)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data["user_name"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                        SizedBox(height: 8,),
                                        Text(data["comment"],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              )





            ],
          ),
        ),
      ),
    );
  }
}
