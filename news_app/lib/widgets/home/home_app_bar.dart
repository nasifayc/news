import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: theme.primary, width: 1)),
          child: Center(
            child: Icon(
              Icons.menu,
              color: theme.info,
              size: 24,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(color: theme.primary, width: 1)),
          child: Center(
            child: Icon(
              Icons.notifications_none,
              color: theme.info,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
