import 'package:flutter/material.dart';

enum SELECTED_LIST { Movies, Music, Books }
enum USER_TYPE { NO_ACCOUNT, OLD_USER, SUBSCRIPTION_USER }

class AppState with ChangeNotifier {
  SELECTED_LIST selectedList = SELECTED_LIST.Movies;
  USER_TYPE userType;
  void changeList(SELECTED_LIST list) {
    selectedList = list;
    notifyListeners();
  }

  void changeUserType(USER_TYPE newUserType) {
    userType = newUserType;
  }
}
