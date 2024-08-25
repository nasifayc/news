import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/user_model.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          UserModel user = state.user;
          return Row(
            children: [
              Container(
                height: 108,
                width: 108,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: state.user.photo != null
                        ? CachedNetworkImageProvider(state.user.photo!)
                        : const AssetImage(
                            "assets/images/megaphone.png"), // Use AssetImage here
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
                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text(
                            'Create news is upcoming feature',
                          ),
                          backgroundColor: theme.info,
                        ));
                      },
                      child: Container(
                        height: 41,
                        decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: Text(
                            'Create news',
                            style: theme.typography.titleMedium2,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          return Center(
            child: Text(
              'Login First!',
              style: theme.typography.headlineMedium,
            ),
          );
        }
      },
    );
  }
}
