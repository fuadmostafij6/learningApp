import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learningapp/service/google_service.dart';
import 'package:learningapp/widget/postWidget.dart';

import '../widget/CustomFeed.dart';

class Feed extends StatelessWidget {
  final String type;
  const Feed({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var size=MediaQuery.of(context).size;

    return customFeed(type);
  }


}
