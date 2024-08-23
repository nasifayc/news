import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/user_model.dart';

class ProfileStatusCard extends StatelessWidget {
  final UserModel user;
  const ProfileStatusCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Row(
      children: [
        Container(
          height: 108,
          width: 108,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: user.photo != null
                  ? NetworkImage(user.photo!)
                  : const AssetImage("assets/images/megaphone.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        user.news.length.toString(),
                        style: theme.typography.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'News',
                        style: theme.typography.headlineSmall2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        user.followers.length.toString(),
                        style: theme.typography.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Followers',
                        style: theme.typography.headlineSmall2,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        user.following.length.toString(),
                        style: theme.typography.titleMedium,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Following',
                        style: theme.typography.headlineSmall2,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 41,
                decoration: BoxDecoration(
                    color: theme.info, borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    'Follow',
                    style: theme.typography.labelMedium,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
