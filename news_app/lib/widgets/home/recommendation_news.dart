import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/home/recommendation_news_card.dart';

class RecommendationNews extends StatefulWidget {
  const RecommendationNews({super.key});

  @override
  State<RecommendationNews> createState() => _RecommendationNewsState();
}

class _RecommendationNewsState extends State<RecommendationNews> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          if (state.allNews.isEmpty) {
            return Text(
              "No news available",
              style: theme.typography.headlineSmall2,
            );
          } else {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.allNews.length,
              itemBuilder: (context, index) {
                NewsModel news = state.allNews[index];
                return Column(
                  children: [
                    RecommendationNewsCard(news: news),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            );
          }
        } else if (state is NewsLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: theme.info,
            ),
          );
        } else if (state is NewsError) {
          return Text(
            state.error,
            style: theme.typography.headlineSmall2,
          );
        } else {
          return const Text("Unknown Error");
        }
      },
    );
  }
}
