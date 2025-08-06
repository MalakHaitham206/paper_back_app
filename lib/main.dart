import 'package:day2_course/screens/splash_screen.dart';
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
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: PaperbackTheme.theme,
      home: const SplashScreen(),
    );
  }
}
