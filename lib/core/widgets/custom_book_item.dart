import 'package:day2_course/core/helper.dart';
import 'package:day2_course/core/widgets/start_rating.dart';
import 'package:day2_course/model/book_model.dart';
import 'package:flutter/material.dart';

class CustomBookCard extends StatelessWidget {
  final Book bookInfo;
  const CustomBookCard({super.key, required this.bookInfo});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: Helper.getResponsiveWidth(context, width: 130),
      height: Helper.getResponsiveHeight(context, height: 100),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              bookInfo.coverImage,
              fit: BoxFit.cover,
              width: Helper.getResponsiveWidth(context, width: 100),
              height: Helper.getResponsiveHeight(context, height: 100),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: Helper.getResponsiveWidth(context, width: 150),
                  height: Helper.getResponsiveHeight(context, height: 180),
                  color: const Color.fromARGB(181, 212, 211, 211),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error,
                          size: 48,
                          color: const Color.fromARGB(255, 161, 40, 40),
                        ),
                        Text(
                          "Image not found",
                          style: TextStyle(color: Color(0xff000000)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: Helper.getResponsiveWidth(context, width: 8)),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookInfo.title,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),

                  Text(
                    "by ${bookInfo.author}",
                    style: theme.textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: Helper.getResponsiveHeight(context, height: 4),
                  ),
                  StarRating(rating: bookInfo.rate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
