
class UserInfo {
  int id;
  String userName;
  String? email;
  String? password;

  UserInfo({
    required this.id,
    required this.userName,
    this.email,
    this.password,
  });

}
