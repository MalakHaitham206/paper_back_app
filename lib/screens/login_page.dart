import 'package:day2_course/core/widgets/custom_text_field_section.dart';
import 'package:day2_course/core/widgets/helper.dart';
import 'package:day2_course/screens/my_home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(Helper.responsiveHeight(context, height: 50)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextFieldSection(
                  label: "Email",
                  placeholderText: "Plant@gmail.com",
                  icon: "assets/image/login_images/email_icon.svg",
                  type: "email",
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                CustomTextFieldSection(
                  label: "Password",
                  placeholderText: "Enter your password",
                  icon: "assets/image/login_images/email_icon.svg",
                  type: "Password",
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Helper.responsiveHeight(context, height: 24),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: "welcome to home page"),
                          ),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
