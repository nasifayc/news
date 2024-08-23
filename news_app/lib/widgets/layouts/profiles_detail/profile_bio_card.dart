import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';

class ProfileBioCard extends StatelessWidget {
  final UserModel user;
  const ProfileBioCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              StaticUtils.capitalize(user.username),
              style: theme.typography.headlineMedium,
              maxLines: 2,
            ),
            user.isVerfied
                ? StaticUtils.getBlueTick(theme)
                : const SizedBox.shrink()
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          user.bio == null
              ? 'This is ${user.username} News, Enjoy!'
              : user.bio!,
          style: theme.typography.titleSmall2,
          maxLines: 4,
        )
      ],
    );
  }
}
