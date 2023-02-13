import 'package:flutter/material.dart';
import 'package:learningapp/service/google_service.dart';
class PostWidget extends StatelessWidget {
  final String displayName;
  final String image;
  final String postText;
  final String commentLength;

  const PostWidget({Key? key, required this.displayName, required this.image, required this.postText,required this.commentLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      // height:size.height/4,
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(10),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage:NetworkImage(image),
              ),
              SizedBox(width: 10,),
              Text("${displayName}")
            ],
          ),
          SizedBox(height: 7,),
         Text(postText),
          SizedBox(height: 5,),
          Divider(color: Colors.black,),
          SizedBox(height: 5,),
          Row (
            children: [
              Icon(Icons.insert_comment,size: 25,),
              SizedBox(width: 5,),
              Text(commentLength,style: TextStyle(fontSize:15,fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ) ,
    );
  }
}
