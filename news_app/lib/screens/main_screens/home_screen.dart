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
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverToBoxAdapter(
              child: HomeAppBar(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            const SliverToBoxAdapter(
              child: WelcomeCard(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 30),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending news',
                    style: theme.typography.titleMedium2,
                  ),
                  Text('See all', style: theme.typography.titleSmall2)
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            const SliverToBoxAdapter(
              child: TrendingNews(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            SliverToBoxAdapter(
              child: Text(
                'Recommendation',
                style: theme.typography.titleMedium2,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ];
        },
        body: RefreshIndicator(
            onRefresh: () async {
              return context.read<NewsCubit>().fetchAllNews();
            },
            child: const RecommendationNews()),
      ),
    );
  }
}
