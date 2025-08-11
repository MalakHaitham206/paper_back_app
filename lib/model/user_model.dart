class UserInfo {
  int id;
  String userName;
  String? email;
  String? password;

  var userImage;

  UserInfo({
    required this.id,
    required this.userName,
    this.email = "nader@gmail.com",
    this.password,
    this.userImage,
  });
}
