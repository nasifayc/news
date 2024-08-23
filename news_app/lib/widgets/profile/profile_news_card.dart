import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';

class ProfileNewsCard extends StatelessWidget {
  final NewsModel news;
  const ProfileNewsCard({super.key, required this.news});

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
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              if (state is Authenticated) {
                UserModel user = state.user;
                return Row(
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
                                  : CachedNetworkImageProvider(user.photo!),
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
                );
              }
              return const SizedBox.shrink();
            },
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
                    image: CachedNetworkImageProvider(news.imageUrl),
                    fit: BoxFit.cover)),
          )
        ],
      ),
    );
  }
}
