

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/screen/ForumScreen.dart';
import 'package:learningapp/screen/homescreen.dart';
import 'package:provider/provider.dart';

import '../constant/flutterToast.dart';
import '../constant/rout_page.dart';
import '../controllar/ForumProvider.dart';
import '../service/google_service.dart';
import '../widget/drower_widget.dart';
import 'ProfileScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BNB extends StatefulWidget {
  const BNB({Key? key}) : super(key: key);

  @override
  State<BNB> createState() => _BNBState();
}

class _BNBState extends State<BNB> {
  var box=Hive.box('user');
  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
  HomePage(),
    ForumScreen(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Post(String type) async {
    var docs = DateTime.now().microsecondsSinceEpoch;
    await Googlehelper.FireBaseStore.collection("Post")
        .doc(docs.toString())
        .set({
      "Post": postController.text,
      "time": FieldValue.serverTimestamp(),
      "type": type,
      "post_id": docs.toString(),
      "comment_length":"0",
      "user_id": box.get('uid'),
      "user_name":box.get('name') ,
      "user_image":box.get('image'),
    });
  }


  Future<void> _showAlertDialog(
      String data,
      ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // <-- SEE HERE
          // title:
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.close_rounded)),
                SizedBox(height: 7,),
                Text('Post Your $data'),
                SizedBox(height: 15,),
                TextFormField(
                  minLines: 2,
                  maxLines: 10,
                  controller:postController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'write your $data',
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
                SizedBox(height: 15,),
                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0)),
                  child: InkWell(
                    onTap: () {
                      if(postController.text.isNotEmpty){
                        Post(data);
                        Navigator.pop(context);
                        postController.clear();
                      }
                      else{
                        NewFlutterToast.errorToast("Please Insert your $data");

                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Post",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }


  TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<ForumProvider>(context,listen: false);
    return Scaffold(
      appBar:

      PreferredSize(
        preferredSize: AppBar().preferredSize,
        child:
        NewAppBar.buildAppBar(name:_selectedIndex==0? "Home":_selectedIndex==1? "Forum":"Profile", ),
      ),
      drawer: buildDrawer(context),
      floatingActionButton:
      _selectedIndex==1?

      Container(
        height: 50,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8.0)),
        child: InkWell(
          onTap: () {
            _showAlertDialog(controller.selectedIndex == 0
                ? "Feed"
                : controller.selectedIndex == 1
                ? "Announcement"
                : "Question");
          },
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.edit,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
      ):null,

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Forum',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
           
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.4),
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5
      ),

      body: AnimatedSwitcher(
        duration: Duration(seconds: 1),
        child: _widgetOptions[_selectedIndex],
      ),


    );


  }


}
