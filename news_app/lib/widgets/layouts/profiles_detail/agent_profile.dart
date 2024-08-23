import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';

class AgentProfile extends StatelessWidget {
  final UserModel user;
  final NewsModel news;
  const AgentProfile({super.key, required this.news, required this.user});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.inputFieldBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                        image: user.photo == null
                            ? Image.asset(
                                'assets/images/megaphone.png',
                              ) as ImageProvider
                            : NetworkImage(
                                user.photo!,
                              ),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        StaticUtils.capitalize(user.username),
                        style: theme.typography.headlineMedium2,
                      ),
                      user.isVerfied
                          ? StaticUtils.getBlueTick(theme)
                          : const SizedBox.shrink()
                    ],
                  ),
                  Text(
                    StaticUtils.formatDate(news.createdDate),
                    style: theme.typography.headlineSmall2,
                  )
                ],
              ),
              const Spacer(),
              Image.asset(
                "assets/images/more.png",
                width: 24,
                height: 24,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            news.title,
            style: theme.typography.titleMedium2,
            maxLines: 3,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.white,
              border: Border.all(width: 1, color: theme.secondaryText),
            ),
            child: Text(
              StaticUtils.capitalize(
                news.category,
              ),
              style: theme.typography.labelSmall3,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(news.imageUrl), fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
