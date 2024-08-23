import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';

class ProfileDetailBar extends StatelessWidget {
  final String username;
  const ProfileDetailBar({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Row(
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
          "${username.toLowerCase()}news",
          style: theme.typography.titleLarge2,
        ),
        const Spacer(),
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
          )),
        ),
      ],
    );
  }
}
