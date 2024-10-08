import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/layouts/profiles_detail_screen.dart';

import 'package:news_app/utils/static_utils.dart';

class RecommendationNewsCard extends StatefulWidget {
  final NewsModel news;
  const RecommendationNewsCard({super.key, required this.news});

  @override
  State<RecommendationNewsCard> createState() => _RecommendationNewsCardState();
}

class _RecommendationNewsCardState extends State<RecommendationNewsCard> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  void updateUser(UserModel user) {
    context.read<AuthenticationCubit>().updateUser(user);
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
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.news.author)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return StaticUtils.getShimmerEffect(height: 36, theme);
              } else if (snapshot.hasError) {
                return Text(
                  'Error fetching user data${snapshot.error}',
                );
              } else if (snapshot.hasData) {
                UserModel user = UserModel.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProfilesDetailScreen(user: user),
                            ));
                          },
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                    image: user.photo == null
                                        ? Image.asset(
                                            'assets/images/megaphone.png',
                                          ) as ImageProvider
                                        : CachedNetworkImageProvider(
                                            user.photo!),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          child: Column(
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
                        ),
                        const Spacer(),
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
                                  List<String> publisherFollowers =
                                      user.followers;

                                  if (!publisherFollowers
                                      .contains(currentUserId)) {
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
                                  width: 115,
                                  decoration: BoxDecoration(
                                      color: isFollower
                                          ? theme.info
                                          : theme.primary,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      isFollower ? 'Following' : 'Follow',
                                      style: isFollower
                                          ? theme.typography.labelMedium
                                          : theme.typography.titleMedium2,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
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
                              image: CachedNetworkImageProvider(
                                  widget.news.imageUrl),
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
