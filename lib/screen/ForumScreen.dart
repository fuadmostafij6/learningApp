import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/constant/flutterToast.dart';
import 'package:learningapp/controllar/ForumProvider.dart';
import 'package:learningapp/screen/Announcment.dart';
import 'package:learningapp/screen/Feed.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:provider/provider.dart';

import '../constant/rout_page.dart';
import 'Question.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({Key? key}) : super(key: key);

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {










  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final  controller = Provider.of<ForumProvider>(context,listen: true);
    final tabBarList = ["Feed", "Announcement", "Question"];
    print(controller.selectedIndex);
    var Pages = [
      Feed(type:controller.selectedIndex == 0
        ? "Feed"
        : controller.selectedIndex == 1
        ? "Announcement"
        : "Question" ,),
      Announcement(type:controller.selectedIndex == 0
        ? "Feed"
        : controller.selectedIndex == 1
        ? "Announcement"
        : "Question" ,),
      Question(type:controller.selectedIndex == 0
        ? "Feed"
        : controller.selectedIndex == 1
        ? "Announcement"
        : "Question" ,)];
    return Scaffold(

      body:


      ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 60,
            child: ListView.builder(

                scrollDirection: Axis.horizontal,
                itemCount: tabBarList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        controller.changeIndex(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: controller.selectedIndex != index
                                ? Colors.grey.withOpacity(0.2)
                                : Colors.black,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            index == 0
                                ? Icon(Icons.list_alt,
                                color: controller.selectedIndex == index
                                    ? Colors.white
                                    : Colors.black)
                                : index == 1
                                ? Icon(Icons.mic_external_on,
                                color: controller.selectedIndex == index
                                    ? Colors.white
                                    : Colors.black)
                                : Icon(Icons.question_mark,
                                color: controller.selectedIndex == index
                                    ? Colors.white
                                    : Colors.black),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              tabBarList[index],
                              style: TextStyle(
                                  fontSize: 16,
                                  color: controller.selectedIndex == index
                                      ? Colors.white
                                      : Colors.black),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          AnimatedSwitcher(
            duration: Duration(seconds: 1),
            child: Pages[controller.selectedIndex],
          )
        ],
      )
      // Consumer<ForumProvider>(builder: ((context, value, child) {
      //
      // return  ListView(
      //   shrinkWrap: true,
      //   primary: false,
      //   children: [
      //     SizedBox(
      //       height: 15,
      //     ),
      //     SizedBox(
      //       height: 60,
      //       child: ListView.builder(
      //
      //           scrollDirection: Axis.horizontal,
      //           itemCount: tabBarList.length,
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: InkWell(
      //                 onTap: () {
      //                   value.changeIndex(index);
      //                 },
      //                 child: Container(
      //                   decoration: BoxDecoration(
      //                       color: value.selectedIndex != index
      //                           ? Colors.grey.withOpacity(0.2)
      //                           : Colors.black,
      //                       borderRadius: BorderRadius.circular(8)),
      //                   child: Row(
      //                     children: [
      //                       SizedBox(
      //                         width: 5,
      //                       ),
      //                       index == 0
      //                           ? Icon(Icons.list_alt,
      //                           color: value.selectedIndex == index
      //                               ? Colors.white
      //                               : Colors.black)
      //                           : index == 1
      //                           ? Icon(Icons.mic_external_on,
      //                           color: value.selectedIndex == index
      //                               ? Colors.white
      //                               : Colors.black)
      //                           : Icon(Icons.question_mark,
      //                           color: value.selectedIndex == index
      //                               ? Colors.white
      //                               : Colors.black),
      //                       SizedBox(
      //                         width: 5,
      //                       ),
      //                       Text(
      //                         tabBarList[index],
      //                         style: TextStyle(
      //                             fontSize: 16,
      //                             color: value.selectedIndex == index
      //                                 ? Colors.white
      //                                 : Colors.black),
      //                         overflow: TextOverflow.ellipsis,
      //                         maxLines: 2,
      //                       ),
      //                       SizedBox(
      //                         width: 5,
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             );
      //           }),
      //     ),
      //     AnimatedSwitcher(
      //       duration: Duration(seconds: 1),
      //       child: Pages[value.selectedIndex],
      //     )
      //   ],
      // );
      //
      // }




    );
  }
}

