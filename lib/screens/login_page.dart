import 'package:day2_course/core/widgets/custom_text_field_section.dart';
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/providers/user_information_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  controller: _emailController,
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
                  controller: _passwordController,
                  validateFunction: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(3),
                            ),
                          ),
                          value: rememberMe,
                          onChanged: (checked) {
                            setState(() {
                              checked == true
                                  ? rememberMe = true
                                  : rememberMe = false;
                            });
                          },
                        ),
                        Text(
                          "Remember me",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: Helper.getResponsiveFontSize(
                              context,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: Helper.getResponsiveFontSize(
                            context,
                            fontSize: 15,
                          ),
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Helper.getResponsiveHeight(context, height: 24),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // context
                        //     .read<UserInformationProvider>()
                        //     .initializeWithTestUsers();
                        if (context.read<UserInformationProvider>().login(
                          mail: _emailController.text,
                          pass: _passwordController.text,
                        )) {
                          Navigator.of(context).pushReplacementNamed('home/');
                        }
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
                        'Log in',
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
                      "Don't have an account?",
                      style: theme.textTheme.bodyLarge?.copyWith(height: 0),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'register/');
                      },
                      child: Text(
                        "Sign up",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: Helper.getResponsiveHeight(context, height: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        color: theme.colorScheme.outline,
                        width: Helper.getResponsiveWidth(
                          context,
                          width: 134.65,
                        ),
                        height: Helper.getResponsiveHeight(context, height: 2),
                      ),
                      Spacer(),
                      Text(
                        "Or",
                        style: theme.textTheme.bodyLarge?.copyWith(height: 0),
                      ),
                      Spacer(),
                      Container(
                        color: theme.colorScheme.outline,
                        width: Helper.getResponsiveWidth(
                          context,
                          width: 134.65,
                        ),
                        height: Helper.getResponsiveHeight(context, height: 2),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/image/login_images/google_icon.svg",
                        width: Helper.getResponsiveWidth(context, width: 20),
                        height: Helper.getResponsiveHeight(context, height: 25),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/image/login_images/facebook_logo.svg",
                        width: Helper.getResponsiveWidth(context, width: 20),
                        height: Helper.getResponsiveHeight(context, height: 25),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/image/login_images/apple_icon.svg",
                        width: Helper.getResponsiveWidth(context, width: 20),
                        height: Helper.getResponsiveHeight(context, height: 25),
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
