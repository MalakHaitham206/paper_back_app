import 'package:day2_course/model/book_model.dart';
import 'package:day2_course/model/user_model.dart';
import 'package:flutter/foundation.dart';

class UserInformationProvider extends ChangeNotifier {
  UserInfo? _currentUser;
  List<UserInfo> users = [];
  UserInfo? get user => _currentUser;
  bool get hasUsers => users.isNotEmpty;
  bool register(UserInfo? userInfo) {
    _currentUser = userInfo;
    if (userInfo != null) {
      users.add(userInfo);
    }

    notifyListeners();
    return true;
  }

  bool login({required String mail, required String pass}) {
    if (users.isEmpty) {
      notifyListeners();
      return false;
    }

    for (UserInfo user in users) {
      if (user.email == mail && user.password == pass) {
        _currentUser = user;
        notifyListeners();
        return true;
      }
    }
    notifyListeners();
    return false;
  }

  void saveTheBooks(List<Book> savedBooks) {
    _currentUser?.savedItems = savedBooks;
    notifyListeners();
  }

  void clearUsers() {
    users.clear();
    _currentUser = null;
    notifyListeners();
  }

  void logOut(UserInfo user) {
    int indexToRemove = -1;

    for (int i = 0; i < users.length; i++) {
      if (users[i].email == user.email && users[i].password == user.password) {
        indexToRemove = i;
        break; // Exit loop once found
      }
    }

    if (indexToRemove != -1) {
      users.removeAt(indexToRemove);
    }

    _currentUser = null;
    notifyListeners();
  }
}
