import 'package:day2_course/core/theme.dart';
import 'package:day2_course/core/helper.dart';
import 'package:day2_course/core/widgets/custom_nav_bar.dart';
import 'package:day2_course/model/user_model.dart';
import 'package:day2_course/providers/user_information_provider.dart';
import 'package:day2_course/screens/login_page.dart';
import 'package:day2_course/screens/my_home_page.dart';
import 'package:day2_course/screens/profile_page.dart';
import 'package:day2_course/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TheHomeRootPage extends StatefulWidget {
  const TheHomeRootPage({super.key});

  @override
  State<TheHomeRootPage> createState() => _RootPage();
}

class _RootPage extends State<TheHomeRootPage> {
  final List<String> _iconPaths = [
    "assets/image/home_images/bottom_nav_home_icon.svg",
    "assets/image/home_images/bottom_nav_save_icon.svg",
    "assets/image/home_images/bottom_nav_search_icon.svg",
    "assets/image/home_images/bottom_nav_bag_icon.svg",
  ];

  int navIndex = 0;
  List<Widget> pages = [MyHomePage(), SearchPage()];

  @override
  void initState() {
    super.initState();
    navIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    UserInfo userData =
        context.watch<UserInformationProvider>().user ??
        UserInfo(id: 0, userName: '');
    final theme = Theme.of(context);
    Map<String, VoidCallback> items = {
      '': () {},
      "Profile": () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      },
      "Recents": () {
        Navigator.pop(context);
      },
      "saved items": () {
        Navigator.pop(context);
      },
      "Settings": () {
        Navigator.pop(context);
      },
      "Notifications": () {
        Navigator.pop(context);
      },
      "Listen Later": () {
        Navigator.pop(context);
      },
      "Help": () {
        Navigator.pop(context);
      },
      "Log out": () {
        context.read<UserInformationProvider>().logOut(userData);
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
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
      Icon(Icons.logout),
    ];
    List<String> titles = ["PaberBack.", "Saved Items", "Search", "Cart"];
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(
          right: Helper.getResponsiveHeight(context, height: 8),
        ),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        // scrolledUnderElevation: 0,
        title: Text(titles[navIndex]),

        actions: [
          IconButton(
            iconSize: Helper.getResponsiveWidth(context, width: 24),
            onPressed: () {},
            icon: Icon(Icons.notifications),
          ),
          userData.userImage != null
              ? IconButton(
                  iconSize: Helper.getResponsiveWidth(context, width: 16),
                  onPressed: () {},
                  icon: Icon(
                    Icons.person,
                    size: Helper.getResponsiveWidth(context, width: 24),
                  ),
                  style: ButtonStyle(
                    iconColor: WidgetStatePropertyAll(
                      const Color.fromARGB(255, 218, 218, 218),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      const Color.fromARGB(255, 89, 89, 89),
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/image/home_images/user_image.png",
                    width: Helper.getResponsiveWidth(context, width: 36),
                    height: Helper.getResponsiveHeight(context, height: 36),
                    fit: BoxFit.cover,
                  ),
                ),
        ],
      ),
      drawer: Consumer<UserInformationProvider>(
        builder: (context, provider, child) {
          return Drawer(
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
                          Icon(
                            Icons.account_circle_rounded,
                            size: Helper.getResponsiveWidth(context, width: 50),
                          ),
                          Text(
                            "${provider.user != null ? provider.user!.userName[0].toUpperCase() : ""}${provider.user != null ? provider.user!.userName.substring(1).toLowerCase() : ""}",
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
                    // index: 2
                    //["","profile","Recent","saved items"]
                    title: Text(items.keys.toList()[index]),
                    onTap: items.values.toList()[index],
                  );
                }
              },
            ),
          );
        },
      ),

      body: pages[navIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: navIndex,
        onTap: (index) => setState(() => navIndex = index),
        iconPaths: _iconPaths,
        selectedColor: Theme.of(context).colorScheme.primary,
        unselectedColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.bgDarker,
        height: Helper.getResponsiveHeight(context, height: 50),
      ),
    );
  }
}
