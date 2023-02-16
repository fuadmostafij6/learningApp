
import 'package:flutter/material.dart';
class ForumProvider extends ChangeNotifier{
  var selectedIndex = 0;

  void changeIndex(int index) {

      selectedIndex = index;
      notifyListeners();

  }


}