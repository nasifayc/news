import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/authentication/authentication_cubit.dart';
import 'package:news_app/controllers/authentication/authentication_state.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/screens/layouts/profiles_detail_screen.dart';

import 'package:news_app/utils/static_utils.dart';

class PublisherCard extends StatefulWidget {
  final UserModel publisher;
  const PublisherCard({super.key, required this.publisher});

  @override
  State<PublisherCard> createState() => _PublisherCardState();
}

class _PublisherCardState extends State<PublisherCard> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    void updateUser(UserModel user) {
      context.read<AuthenticationCubit>().updateUser(user);
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
          color: theme.inputFieldBackground,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ProfilesDetailScreen(user: widget.publisher),
              ));
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: widget.publisher.photo == null
                        ? const AssetImage('assets/images/megaphone.png')
                        : CachedNetworkImageProvider(widget.publisher.photo!),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Text(
            '${StaticUtils.capitalize(widget.publisher.username)} News',
            style: theme.typography.titleMedium2,
            maxLines: 3,
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.publisher.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return StaticUtils.getShimmerEffect(theme);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                UserModel user = UserModel.fromJson(
                    snapshot.data!.data() as Map<String, dynamic>);
                return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      bool isFollower = user.followers.contains(state.user.id);
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
                          width: 115,
                          decoration: BoxDecoration(
                              color: isFollower ? theme.info : theme.primary,
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



// FutureBuilder(
//             future: getUserModel(widget.publisher.id),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const SizedBox.shrink();
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if (snapshot.hasData) {
//                 final user = snapshot.data;
//                 return user != null
//                     ? BlocBuilder<AuthenticationCubit, AuthenticationState>(
//                         builder: (context, state) {
//                           if (state is Authenticated) {
//                             bool isFollower =
//                                 user.followers.contains(state.user.id);
//                             return GestureDetector(
//                               onTap: () {
//                                 String currentUserId = state.user.id;
//                                 List<String> publisherFollowers =
//                                     user.followers;

//                                 if (!publisherFollowers
//                                     .contains(currentUserId)) {
//                                   publisherFollowers.add(currentUserId);
//                                   state.user.following.add(user.id);
//                                   user.followers = publisherFollowers;
//                                   setState(() {
//                                     updateUser(user);
//                                     updateUser(state.user);
//                                   });
//                                 } else {
//                                   publisherFollowers.remove(currentUserId);
//                                   state.user.following.remove(user.id);
//                                   user.followers = publisherFollowers;
//                                   setState(() {
//                                     updateUser(user);
//                                     updateUser(state.user);
//                                   });
//                                 }
//                               },
//                               child: Container(
//                                 height: 41,
//                                 width: 115,
//                                 decoration: BoxDecoration(
//                                     color:
//                                         isFollower ? theme.info : theme.primary,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: Center(
//                                   child: Text(
//                                     isFollower ? 'Following' : 'Follow',
//                                     style: isFollower
//                                         ? theme.typography.labelMedium
//                                         : theme.typography.titleMedium2,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           } else {
//                             return const SizedBox.shrink();
//                           }
//                         },
//                       )
//                     : const Text('User not found');
//               } else {
//                 return const SizedBox.shrink();
//               }
//             },
//           ),
