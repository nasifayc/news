import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/services/authentication_services.dart';
import 'package:news_app/utils/static_utils.dart';

class RecommendationNewsCard extends StatefulWidget {
  final NewsModel news;
  const RecommendationNewsCard({super.key, required this.news});

  @override
  State<RecommendationNewsCard> createState() => _RecommendationNewsCardState();
}

class _RecommendationNewsCardState extends State<RecommendationNewsCard> {
  AuthenticationServices auth = AuthenticationServices();
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future<UserModel?> getUserModel(String id) async {
    return await auth.getUser(id);
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.inputFieldBackground),
      child: Column(
        children: [
          FutureBuilder(
            future: getUserModel(widget.news.author),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.info,
                  ),
                );
              } else if (snapshot.hasError) {
                return Text(
                  'Error fetching user data${snapshot.error}',
                );
              } else if (snapshot.hasData) {
                UserModel user = snapshot.data!;
                return Column(
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
                                  capitalize(user.username),
                                  style: theme.typography.headlineMedium2,
                                ),
                                user.isVerfied
                                    ? Image.asset(
                                        'assets/images/verify.png',
                                        width: 18,
                                        height: 18,
                                        color: theme.secondaryText,
                                      )
                                    : const SizedBox.shrink()
                              ],
                            ),
                            Text(
                              StaticUtils.formatDate(widget.news.createdDate),
                              style: theme.typography.headlineSmall2,
                            )
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: null,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: theme.primary,
                            ),
                            child: Text(
                              'Follow',
                              style: theme.typography.titleMedium2,
                            ),
                          ),
                        ),
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
                      widget.news.title,
                      style: theme.typography.titleMedium2,
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.white,
                        border:
                            Border.all(width: 1, color: theme.secondaryText),
                      ),
                      child: Text(
                        capitalize(
                          widget.news.category,
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
                              image: NetworkImage(widget.news.imageUrl),
                              fit: BoxFit.cover)),
                    )
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          )
        ],
      ),
    );
  }
}
