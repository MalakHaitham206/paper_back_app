import 'package:day2_course/screens/login_page.dart';
import 'package:day2_course/screens/my_home_page.dart';
import 'package:day2_course/screens/on_boarding.dart';
import 'package:day2_course/screens/register_page.dart';
import 'package:day2_course/screens/root_page.dart';
import 'package:day2_course/screens/splash_screen.dart';
import 'package:day2_course/screens/user_profile.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:device_preview/device_preview.dart';
import 'package:day2_course/core/theme.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login/": (context) => LoginPage(),
        'register/': (context) => RegisterPage(),
        'onboarding/': (context) => OnBoarding(),
        'home/': (context) => RootPage(),
        'userProfile/': (context) => UserProfile(),
      },
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: PaperbackTheme.theme,
      home: SplashScreen(),
    );
  }
}
