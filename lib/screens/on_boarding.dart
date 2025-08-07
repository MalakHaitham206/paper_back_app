import 'package:day2_course/core/theme.dart';
import 'package:day2_course/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Paperback.", style: theme.titleStyle),
          centerTitle: true,
          backgroundColor: theme.colorScheme.onSurface,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/image/onboard_images/background.png"),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 70),
                SvgPicture.asset("assets/image/onboard_images/reader_girl.svg"),
                SizedBox(height: 100),
                Column(
                  children: [
                    Text(
                      "A NEW WAY TO READ",
                      style: TextStyle(
                        fontFamily: "Karla",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Start reading the world’s best books for free today",
                      style: TextStyle(
                        fontFamily: "Newsreader",
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: theme.colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "The first completely free audio book library with the latest world titles available right now.",
                        style: theme.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 4,
                    ),
                    child: Text("Get Started"),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
