import 'dart:math';

import 'package:day2_course/core/theme.dart';
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/model/user_model.dart';
import 'package:day2_course/screens/my_home_page.dart';
import 'package:day2_course/screens/saved_box.dart';
import 'package:day2_course/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  int _selectedIndex = 0;

  // List of icon paths for cleaner code
  final List<String> _iconPaths = [
    "assets/image/home_images/bottom_nav_home_icon.svg",
    "assets/image/home_images/bottom_nav_save_icon.svg",
    "assets/image/home_images/bottom_nav_search_icon.svg",
    "assets/image/home_images/bottom_nav_bag_icon.svg",
  ];
  var isChecked = true;
  String? selectedOption = "option1";
  var isEnabled = true;
  final bool _isExpanded = false;
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
  }

  @override
  Widget build(BuildContext context) {
    UserInfo? userData = ModalRoute.of(context)?.settings.arguments as UserInfo;

    print(userData.userName);
    return Scaffold(
      appBar: AppBar(title: Text("HomePage")),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text("Header")),
            ListTile(
              title: Text("home"),
              onTap: () => Navigator.of(context).pushNamed('login/'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black26,
      body: pages[navIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        iconPaths: _iconPaths,
        // Pass theme colors here
        selectedColor: Theme.of(context).colorScheme.primary,
        unselectedColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.bgDarker,
        height: Helper.getResponsiveHeight(context, height: 50),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (value) => setState(() {
      //     navIndex = value;
      //   }),
      //   currentIndex: navIndex,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         "assets/image/home_images/bottom_nav_search_icon.svg",
      //       ),
      //       label: "first item",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(
      //         "assets/image/home_images/bottom_nav_home_icon.svg",
      //       ),
      //       label: "second item",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.access_time),
      //       label: "third item",
      //     ),
      //   ],
      // ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<String> iconPaths;

  // Customizable properties
  final double height;
  final double iconSize;
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundColor;
  final double elevation;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.iconPaths,
    this.height = 60.0,
    this.iconSize = 24.0,
    required this.selectedColor, // Made required to force theme usage
    required this.unselectedColor, // Made required to force theme usage
    required this.backgroundColor, // Made required to force theme usage
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height < 50 ? 50.0 : height;

    return Container(
      padding: const EdgeInsets.all(0),
      height: effectiveHeight + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white)),
        ),
        height: effectiveHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(iconPaths.length, (index) {
            final isSelected = selectedIndex == index;
            return Expanded(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => onTap(index),
                  splashColor: selectedColor.withOpacity(0.2),
                  highlightColor: selectedColor.withOpacity(0.1),
                  child: SizedBox(
                    height: effectiveHeight,
                    child: Center(
                      child: SizedBox(
                        width: iconSize,
                        height: iconSize,
                        child: SvgPicture.asset(
                          iconPaths[index],
                          width: iconSize,
                          height: iconSize,
                          color: isSelected ? selectedColor : unselectedColor,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// Alternative approach: Theme-aware bottom navigation that automatically uses theme colors
class ThemedCustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<String> iconPaths;
  final double height;
  final double iconSize;
  final double elevation;

  const ThemedCustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.iconPaths,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.elevation = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: height + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: theme.colorScheme.bgDarker,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(iconPaths.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => onTap(index),
                    splashColor: theme.colorScheme.primary.withOpacity(0.2),
                    highlightColor: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      height: height,
                      child: Center(
                        child: SizedBox(
                          width: iconSize,
                          height: iconSize,
                          child: SvgPicture.asset(
                            iconPaths[index],
                            width: iconSize,
                            height: iconSize,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.white,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
