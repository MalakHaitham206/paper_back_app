import 'package:day2_course/core/widgets/custom_text_field_section.dart';
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/model/user_model.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool rememberMe = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    UserInfo user = UserInfo(id: 0, userName: '');
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                "assets/image/login_images/login_background.png",
              ),
            ),
          ),
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
                  "Register",
                  style: theme.textTheme.displayLarge?.copyWith(
                    fontSize: Helper.getResponsiveFontSize(
                      context,
                      fontSize: 40,
                    ),
                  ),
                ),
                CustomTextFieldSection(
                  label: "UserName",
                  placeholderText: "Enter your email",
                  icon: "assets/image/register_images/username_icon.svg",
                  type: "username",
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.length <= 2) {
                      return 'Please enter a valid username';
                    }
                    user.userName = value;
                    return null;
                  },
                ),
                CustomTextFieldSection(
                  label: "email",
                  placeholderText: "Enter your email",
                  icon: "assets/image/login_images/email_icon.svg",
                  type: "email",
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (value.length <= 2 ||
                        !value.contains("@") ||
                        !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    user.email = value;
                    return null;
                  },
                ),
                CustomTextFieldSection(
                  label: "Password",
                  placeholderText: "Enter your password",
                  icon: "assets/image/login_images/pass_icon.svg",
                  type: "Password",
                  controller: _passwordController,
                  validateFunction: PasswordValidator.validatePassword,
                ),
                CustomTextFieldSection(
                  label: "Confirm Password",
                  placeholderText: "Confirm your password",
                  icon: "assets/image/login_images/pass_icon.svg",
                  type: "Password",
                  controller: _confirmPasswordController,
                  validateFunction: (value) {
                    PasswordValidator.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    );
                    user.password = value;
                    return null;
                  },
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: Helper.getResponsiveHeight(context, height: 24),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(
                          context,
                        ).pushNamed('home/', arguments: user);
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Helper.getResponsiveWidth(
                          context,
                          width: 100,
                        ),
                        vertical: Helper.getResponsiveWidth(context, width: 4),
                      ),
                      child: Text(
                        'Sign up',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontSize: Helper.getResponsiveFontSize(
                            context,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: theme.textTheme.bodyLarge?.copyWith(height: 0),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Sign in",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
