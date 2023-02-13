
import 'package:flutter/material.dart';

import '../widget/CustomFeed.dart';
class Announcement extends StatelessWidget {
  final String type;
  const Announcement({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return customFeed(type);
  }
}
