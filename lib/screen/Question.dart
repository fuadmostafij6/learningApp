
import 'package:flutter/material.dart';

import '../widget/CustomFeed.dart';
class Question extends StatelessWidget {
  final String type;
  const Question({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customFeed(type);
  }
}
