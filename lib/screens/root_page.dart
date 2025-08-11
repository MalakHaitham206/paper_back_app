import 'package:day2_course/core/theme.dart';
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/core/widgets/custom_nav_bar.dart';
import 'package:day2_course/model/user_model.dart';
import 'package:day2_course/screens/my_home_page.dart';
import 'package:day2_course/screens/profile_page.dart';
import 'package:day2_course/screens/saved_box.dart';
import 'package:day2_course/screens/search_page.dart';
import 'package:flutter/material.dart';

class TheHomeRootPage extends StatefulWidget {
  const TheHomeRootPage({super.key});

  @override
  State<TheHomeRootPage> createState() => _RootPage();
}

class _RootPage extends State<TheHomeRootPage> {
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
  int navIndex = 0;
  List<Widget> pages = [MyHomePage(), SearchPage(), SavedItemsPage()];

  @override
  void initState() {
    super.initState();
    navIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    UserInfo? userData = ModalRoute.of(context)?.settings.arguments as UserInfo;
    final theme = Theme.of(context);
    Map<String, VoidCallback?> items = {
      '': null, // or remove this empty entry entirely
      "Profile": () {
        Navigator.pop(context); // Close drawer first
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      "Recents": () {
        // Add your logic here
        Navigator.pop(context);
      },
      "saved items": () {
        // Add your logic here
        Navigator.pop(context);
      },
      "Settings": () {
        // Add your logic here
        Navigator.pop(context);
      },
      "Notifications": () {
        // Add your logic here
        Navigator.pop(context);
      },
      "Listen Later": () {
        // Add your logic here
        Navigator.pop(context);
      },
      "Help": () {
        // Add your logic here
        Navigator.pop(context);
      },
    };
    List<Icon?> drawIcons = [
      null,
      Icon(Icons.person),
      Icon(Icons.access_time_filled_outlined),
      Icon(Icons.bookmark),
      Icon(Icons.settings),
      Icon(Icons.notifications),
      Icon(Icons.watch_later_rounded),
      Icon(Icons.help),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("PaberBack.")),
      drawer: Drawer(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return SizedBox(
                height: Helper.getResponsiveHeight(context, height: 130),
                child: DrawerHeader(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.account_circle_rounded,
                          size: Helper.getResponsiveWidth(context, width: 50),
                        ),
                      ),
                      Text(
                        "${userData.userName[0].toUpperCase()}${userData.userName.substring(1)}",
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        textAlign: TextAlign.left,
                        userData.email ?? "your email not recieved yet.",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return ListTile(
                leading: drawIcons[index],
                title: Text(items.keys.toList()[index]),
                onTap: items.values.toList()[index],
              );
            }
          },
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
    );
  }
}
