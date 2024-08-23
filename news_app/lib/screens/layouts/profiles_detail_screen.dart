import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/layouts/profiles_detail/agent_news.dart';
import 'package:news_app/widgets/layouts/profiles_detail/profile_bio_card.dart';
import 'package:news_app/widgets/layouts/profiles_detail/profile_detail_bar.dart';
import 'package:news_app/widgets/layouts/profiles_detail/profile_status_card.dart';

class ProfilesDetailScreen extends StatefulWidget {
  final UserModel user;
  const ProfilesDetailScreen({super.key, required this.user});

  @override
  State<ProfilesDetailScreen> createState() => _ProfilesDetailScreenState();
}

class _ProfilesDetailScreenState extends State<ProfilesDetailScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ProfileDetailBar(
                username: widget.user.username,
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileStatusCard(
                user: widget.user,
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileBioCard(
                user: widget.user,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<NewsCubit, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoaded) {
                    List<NewsModel> news = [];
                    for (var newsModel in state.allNews) {
                      if (newsModel.author == widget.user.id) {
                        news.add(newsModel);
                      }
                    }

                    return AgentNews(
                      newslist: news,
                      user: widget.user,
                    );
                  }
                  return StaticUtils.getShimmerEffect(theme);
                },
              )
            ],
          ),
        ),
      )),
    );
  }
}
