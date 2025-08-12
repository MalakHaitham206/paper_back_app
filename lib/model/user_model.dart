import 'package:day2_course/model/book_model.dart';

class UserInfo {
  int id;
  String userName;
  String? email;
  String? password;
  String? userImage;
  List<Book?> savedItems = [];

  UserInfo({
    required this.id,
    required this.userName,
    this.email = "nader@gmail.com",
    this.password,
    this.userImage,
  });
}
