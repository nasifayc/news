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
          child: Stack(children: [
        SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
        )),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          child: SearchAppBar(),
        )
      ])),
    );
  }
}
