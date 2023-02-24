import 'package:flutter/material.dart';
import 'package:learningapp/constant/rout_page.dart';
import 'package:learningapp/screen/auth/loginScreen.dart';

import '../screen/ForumScreen.dart';
import '../screen/auth/google_loginpage.dart';
import '../service/google_service.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        SizedBox(
          height: 15,
        ),
        // CircleAvatar(
        //   radius: 90,
        //   backgroundColor: Colors.black,
        //   child: CircleAvatar(
        //     radius: 80,
        //     backgroundImage:
        //         NetworkImage(Googlehelper.firebaseAuth.currentUser!.photoURL!),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              tileColor: Colors.grey.withOpacity(0.2),
              title: Text(
                "Forum",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () async {
                NewPageRout.newPage(context, ForumScreen());
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              tileColor: Colors.grey.withOpacity(0.2),
              title: Text(
                "Log out",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              onTap: () async {
                await Googlehelper.googlesignin.signOut();
                await Googlehelper.firebaseAuth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (c) => LoginPage()),
                    (route) => false);
              },
            ),
          ),
        )
      ],
    ),
  );
}
