import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class DiscoverAppBar extends StatelessWidget {
  const DiscoverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Discover',
          style: theme.typography.headlineLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Uncover a world of captivating stories and stay informed',
          style: theme.typography.headlineMedium2,
          maxLines: 4,
        )
      ],
    );
  }
}
