import 'package:day2_course/model/user_model.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    UserInfo user = ModalRoute.of(context)?.settings.arguments as UserInfo;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(user.userName),
            Text(user.email ?? "null"),
            Text(user.id.toString()),
            Text(user.password != null ? user.password! : "null"),
          ],
        ),
      ),
    );
  }
}
