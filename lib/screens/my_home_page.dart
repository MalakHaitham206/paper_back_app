import 'dart:math';

import 'package:day2_course/core/theme.dart';
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/model/user_model.dart';
import 'package:day2_course/screens/saved_box.dart';
import 'package:day2_course/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int _selectedIndex = 0;

  // List of icon paths for cleaner code
  final List<String> _iconPaths = [
    "assets/image/home_images/bottom_nav_home_icon.svg",
    "assets/image/home_images/bottom_nav_save_icon.svg",
    "assets/image/home_images/bottom_nav_search_icon.svg",
    "assets/image/home_images/bottom_nav_bag_icon.svg",
  ];
  var isChecked = false;
  String? selectedOption = "option1";
  var isEnabled = true;
  bool _isExpanded = false;
  @override
  Matrix4 _transformMatrix = Matrix4.identity();

  void _rotateContainer() {
    setState(() {
      _transformMatrix = Matrix4.rotationZ(Random().nextDouble() * pi * 2);
    });
  }

  int navIndex = 0;
  List<Widget> pages = [MyHomePage(), SearchPage(), SavedItemsPage()];
  @override
  void initState() {
    navIndex = 0;
    isChecked = false;
    selectedOption = "option1";
    isEnabled = true;
  }

  @override
  Widget build(BuildContext context) {
    UserInfo? userData = ModalRoute.of(context)?.settings.arguments as UserInfo;

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // // Checkbox - multiple selections
            // Checkbox(
            //   value: isChecked,
            //   onChanged: (bool? value) {
            //     setState(() {
            //       isChecked = value ?? false;
            //     });
            //   },
            // ),

            // // Radio - single selection from group
            Radio<String>(
              value: 'option1',
              groupValue: selectedOption,
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                  print(selectedOption);
                });
              },
            ),
            Radio<String>(
              value: 'option2',
              groupValue: selectedOption,
              onChanged: (String? value) {
                setState(() {
                  selectedOption = value;
                  print(selectedOption);
                });
              },
            ),
            Radio<String>(
              value: "Option23",
              onChanged: (value) => setState(() {
                selectedOption = value;
              }),
              groupValue: selectedOption,
            ),
            // Switch - on/off toggle
            Switch(
              value: isEnabled,
              onChanged: (bool value) {
                setState(() {
                  isEnabled = value;
                });
              },
            ),
            AnimatedContainer(
              duration: Duration(seconds: 1),

              width: _isExpanded ? 100 : 200,
              height: _isExpanded ? 100 : 200,
              transform: _transformMatrix,
              color: _isExpanded
                  ? Colors.red
                  : const Color.fromARGB(9, 33, 149, 243),
              curve: Curves.linear,
              // child: Center(child: Text('Animated!')),
              child: Center(
                child: Text(
                  'Animated!',
                  style: TextStyle(backgroundColor: Color(0xff000000)),
                ),
              ),
            ),

            // Trigger animation
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                _rotateContainer();
              },
              child: Text('Animate'),
            ),
          ],
        ),
      ),
    );
  }
}
