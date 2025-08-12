import 'package:day2_course/core/helper.dart';
import 'package:day2_course/core/widgets/custom_book_item.dart';
import 'package:day2_course/model/book_model.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int count = 2;
  @override
  void initState() {
    super.initState();
    count = 2;
  }

  void seeMoreFunc(length) {
    if (count >= length) {
      setState(() {
        count = length;
      });
    } else {
      setState(() {
        if ((count + 2) > length) {
          count = length;
        } else {
          // count += 2;
          count = count + 2;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.all(Helper.getResponsiveWidth(context, width: 16)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Replace Spacer() with SizedBox for fixed spacing
            SizedBox(height: Helper.getResponsiveHeight(context, height: 24)),
            Text(
              "Discover your next favorite\nbook",
              textAlign: TextAlign.left,
              style: theme.textTheme.displayMedium,
            ),
            SizedBox(height: Helper.getResponsiveHeight(context, height: 32)),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: Helper.getResponsiveHeight(context, height: 264),
              child: ListView.builder(
                itemExtent: Helper.getResponsiveWidth(context, width: 200),
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      print("Tapped on book ${index + 1}");
                    },
                    child: Container(
                      width: Helper.getResponsiveWidth(context, width: 181),
                      height: Helper.getResponsiveHeight(context, height: 240),
                      margin: EdgeInsets.only(
                        right: Helper.getResponsiveWidth(context, width: 16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          books[index].coverImage,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.book,
                                size: 48,
                                color: Colors.grey.shade600,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: Helper.getResponsiveHeight(context, height: 32)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Your favorites",
                      textAlign: TextAlign.left,
                      style: theme.textTheme.displayMedium,
                    ),
                    Text(
                      "Your saved list of favorites",
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                TextButton(
                  onPressed: () {
                    seeMoreFunc(books.length);
                  },
                  child: Text("See more", textAlign: TextAlign.start),
                ),
              ],
            ),
            SizedBox(height: Helper.getResponsiveHeight(context, height: 16)),
            ListView.builder(
              itemExtent: Helper.getResponsiveHeight(context, height: 120),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: count,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print("Tapped on book ${index + 1}");
                  },
                  child: Container(
                    width: Helper.getResponsiveWidth(context, width: 181),
                    height: Helper.getResponsiveHeight(context, height: 110),
                    margin: EdgeInsets.only(
                      right: Helper.getResponsiveWidth(context, width: 16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CustomBookCard(bookInfo: books[index]),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
