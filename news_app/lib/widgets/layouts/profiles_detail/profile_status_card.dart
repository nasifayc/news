import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/user_model.dart';

import 'package:news_app/utils/static_utils.dart';

class ProfileStatusCard extends StatefulWidget {
  final UserModel user;
  const ProfileStatusCard({super.key, required this.user});

  @override
  State<ProfileStatusCard> createState() => _ProfileStatusCardState();
}

class _ProfileStatusCardState extends State<ProfileStatusCard> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    void updateUser(UserModel user) {
      context.read<AuthenticationCubit>().updateUser(user);
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return StaticUtils.getShimmerEffect(theme);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          UserModel user =
              UserModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
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
                    BlocBuilder<AuthenticationCubit, AuthenticationState>(
                      builder: (context, state) {
                        if (state is Authenticated) {
                          if (state.user.id == user.id) {
                            return const SizedBox.shrink();
                          }
                          bool isFollower =
                              user.followers.contains(state.user.id);
                          return GestureDetector(
                            onTap: () {
                              String currentUserId = state.user.id;
                              List<String> publisherFollowers = user.followers;

                              if (!publisherFollowers.contains(currentUserId)) {
                                publisherFollowers.add(currentUserId);
                                state.user.following.add(user.id);
                                user.followers = publisherFollowers;

                                updateUser(user);
                                updateUser(state.user);
                              } else {
                                publisherFollowers.remove(currentUserId);
                                state.user.following.remove(user.id);
                                user.followers = publisherFollowers;

                                updateUser(user);
                                updateUser(state.user);
                              }
                            },
                            child: Container(
                              height: 41,
                              decoration: BoxDecoration(
                                  color: theme.info,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  isFollower ? 'Following' : 'Follow',
                                  style: theme.typography.labelMedium,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Text(
                            'Login First',
                            style: theme.typography.headlineMedium,
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
