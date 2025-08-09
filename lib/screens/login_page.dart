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
          padding: EdgeInsets.symmetric(
            horizontal: Helper.getResponsiveHeight(context, height: 32),
          ),
          margin: EdgeInsets.only(
            top: Helper.getResponsiveHeight(context, height: 98),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Text(
                  "Login",
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: Helper.getResponsiveFontSize(
                      context,
                      fontSize: 40,
                    ),
                  ),
                ),
                CustomTextFieldSection(
                  label: "Email",
                  placeholderText: "Enter your email",
                  icon: "assets/image/login_images/email_icon.svg",
                  type: "email",
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                CustomTextFieldSection(
                  label: "Password",
                  placeholderText: "Enter your password",
                  icon: "assets/image/login_images/pass_icon.svg",
                  type: "Password",
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Helper.getResponsiveHeight(context, height: 24),
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
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Helper.getResponsiveWidth(
                          context,
                          width: 104,
                        ),
                        vertical: Helper.getResponsiveWidth(context, width: 4),
                      ),
                      child: Text(
                        'Log in',
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
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
