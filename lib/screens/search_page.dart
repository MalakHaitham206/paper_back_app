import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isAnimated = false;
  bool mn = false;

  @override
  void initState() {
    super.initState();
    isAnimated = false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  isAnimated = !isAnimated;
                });
              },
              child: AnimatedContainer(
                width: isAnimated ? 200 : 100,
                height: isAnimated ? 200 : 100,
                duration: Duration(seconds: 1),
                color: isAnimated == false
                    ? Color.fromARGB(255, 170, 26, 26)
                    : Color.fromARGB(255, 215, 229, 24),
                curve: Curves.fastOutSlowIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
