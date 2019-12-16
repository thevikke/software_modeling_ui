import 'package:flutter/material.dart';

enum SELECTED_LIST { Movies, Music, Books }

class AppState with ChangeNotifier {
  SELECTED_LIST selectedList = SELECTED_LIST.Movies;

  void changeList(SELECTED_LIST list) {
    selectedList = list;
    notifyListeners();
  }
}
