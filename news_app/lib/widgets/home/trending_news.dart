import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/home/trending_news_card.dart';

class TrendingNews extends StatefulWidget {
  const TrendingNews({super.key});

  @override
  State<TrendingNews> createState() => _TrendingNewsState();
}

class _TrendingNewsState extends State<TrendingNews> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: BlocBuilder<NewsCubit, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return StaticUtils.getShimmerEffect(theme);
          } else if (state is NewsLoaded) {
            if (state.allNews.isEmpty) {
              return Center(
                  child: Text(
                'No trending news available.',
                style: theme.typography.titleSmall2,
              ));
            } else {
              return ListView.builder(
                  itemCount: state.allNews.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final NewsModel news = state.allNews[index];
                    return Row(
                      children: [
                        TrendingNewsCard(news: news),
                        const SizedBox(width: 16),
                      ],
                    );
                  });
            }
          } else if (state is NewsError) {
            return Center(
                child: Text(
              state.error,
              style: theme.typography.titleSmall2,
            ));
          } else {
            return Center(
              child: Text(
                'Unknown error',
                style: theme.typography.titleSmall2,
              ),
            );
          }
        },
      ),
    );
  }
}
