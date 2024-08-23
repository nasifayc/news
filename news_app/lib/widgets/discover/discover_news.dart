import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/widgets/home/recommendation_news.dart';

class DiscoverNews extends StatefulWidget {
  const DiscoverNews({super.key});

  @override
  State<DiscoverNews> createState() => _DiscoverNewsState();
}

class _DiscoverNewsState extends State<DiscoverNews>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    return Column(
      children: [
        TabBar(
          isScrollable: true,
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Recommended'),
            Tab(text: 'Popular'),
            Tab(text: 'Most visited'),
            Tab(text: 'Trending'),
          ],
          labelColor: theme.secondaryText,
          unselectedLabelColor: theme.accent2,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: theme.secondaryText,
                width: 2.0,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              RecommendationNews(),
              RecommendationNews(),
              RecommendationNews(),
              RecommendationNews(),
              RecommendationNews(),
            ],
          ),
        ),
      ],
    );
  }
}
