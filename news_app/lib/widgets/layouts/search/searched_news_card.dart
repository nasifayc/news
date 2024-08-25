import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/layouts/profiles_detail_screen.dart';
import 'package:news_app/services/authentication_services.dart';
import 'package:news_app/utils/static_utils.dart';

class SearchedNewsCard extends StatelessWidget {
  final NewsModel newsModel;
  const SearchedNewsCard({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    AuthenticationServices auth = AuthenticationServices();
    // String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    Future<UserModel?> getUserModel(String id) async {
      return await auth.getUser(id);
    }

    AppTheme theme = AppTheme.of(context);
    return Row(
      children: [
        Container(
          width: 118,
          height: 114,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(newsModel.imageUrl),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsModel.title,
              style: theme.typography.titleMedium2,
              maxLines: 3,
            ),
            const SizedBox(
              height: 15,
            ),
            FutureBuilder<UserModel?>(
              future: getUserModel(newsModel.author),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return StaticUtils.getShimmerEffect(height: 25, theme);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final user = snapshot.data;
                  return user != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      ProfilesDetailScreen(user: user),
                                ));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      image: DecorationImage(
                                        image: user.photo == null
                                            ? const AssetImage(
                                                'assets/images/megaphone.png')
                                            : CachedNetworkImageProvider(
                                                user.photo!),
                                        fit: BoxFit
                                            .cover, // This ensures the image fits the box properly
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '${user.username.toUpperCase()} News',
                                    style: theme.typography.titleSmall2,
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
                            ),
                            Text(
                              StaticUtils.formatDate(newsModel.createdDate),
                              style: theme.typography.titleSmall2,
                            )
                          ],
                        )
                      : const Text('User not found');
                } else {
                  // If the snapshot has no data, this will handle any null cases
                  return const Text('No user data available');
                }
              },
            ),
          ],
        ))
      ],
    );
  }
}
