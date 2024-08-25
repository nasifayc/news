import 'package:flutter/material.dart';
import 'package:news_app/widgets/layouts/search/filter_card.dart';
import 'package:news_app/widgets/layouts/search/search_app_bar.dart';
import 'package:news_app/widgets/layouts/search/searched_news.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchAppBar(),
            SizedBox(
              height: 20,
            ),
            FilterCard(),
            SizedBox(
              height: 20,
            ),
            SearchedNews(),
          ],
        ),
      ))),
    );
  }
}
