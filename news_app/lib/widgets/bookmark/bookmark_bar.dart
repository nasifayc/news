import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class BookmarkBar extends StatelessWidget {
  const BookmarkBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bookmarks',
              style: theme.typography.headlineLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Personal collection of noteworthy reads',
              style: theme.typography.headlineMedium2,
              maxLines: 4,
            )
          ],
        )),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: theme.primary, width: 1)),
          child: Center(
            child: Image.asset(
              "assets/images/more.png",
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }
}
