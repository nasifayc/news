import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/widgets/home/home_app_bar.dart';
import 'package:news_app/widgets/home/recommendation_news.dart';
import 'package:news_app/widgets/home/trending_news.dart';
import 'package:news_app/widgets/home/welcome_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          return context.read<NewsCubit>().fetchAllNews();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeAppBar(),
                const SizedBox(
                  height: 30,
                ),
                const WelcomeCard(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trending news',
                      style: theme.typography.titleMedium2,
                    ),
                    Text('See all', style: theme.typography.titleSmall2)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const TrendingNews(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Recommendation',
                  style: theme.typography.titleMedium2,
                ),
                const SizedBox(
                  height: 20,
                ),
                const RecommendationNews(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
