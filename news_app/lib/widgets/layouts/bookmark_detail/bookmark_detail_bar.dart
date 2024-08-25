import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class BookmarkDetailBar extends StatelessWidget {
  final String category;
  const BookmarkDetailBar({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10.0),
      color: Colors.white,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: theme.primary, width: 1)),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: theme.info,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            category,
            style: theme.typography.titleLarge2,
          ),
        ],
      ),
    );
  }
}
