import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/home/recommendation_news_card.dart';
import 'package:news_app/widgets/layouts/bookmark_detail/bookmark_detail_bar.dart';

class BookmarkDetail extends StatelessWidget {
  final List<NewsModel> news;
  final String category;
  const BookmarkDetail({super.key, required this.news, required this.category});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
                child: Column(
                  children: [
                    BlocBuilder<NewsCubit, NewsState>(
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
                              itemCount: news.length,
                              itemBuilder: (context, index) {
                                NewsModel newsModel = news[index];
                                return Column(
                                  children: [
                                    RecommendationNewsCard(news: newsModel),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        } else if (state is NewsLoading) {
                          return StaticUtils.getShimmerEffect(theme);
                        } else if (state is NewsError) {
                          return Text(
                            state.error,
                            style: theme.typography.headlineSmall2,
                          );
                        } else {
                          return const Text("Unknown Error");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: BookmarkDetailBar(
                category: category,
              ),
            )
          ],
        ),
      ),
    );
  }
}
