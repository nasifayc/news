import 'package:flutter/material.dart';
import 'package:news_app/widgets/profile/profile_app_bar.dart';
import 'package:news_app/widgets/profile/profile_card.dart';
import 'package:news_app/widgets/profile/profile_news.dart';
import 'package:news_app/widgets/profile/user_bio_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                ProfileCard(),
                SizedBox(
                  height: 20,
                ),
                UserBioCard(),
                SizedBox(
                  height: 20,
                ),
                ProfileNews(),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: ProfileAppBar(),
        )
      ]),
    );
  }
}
