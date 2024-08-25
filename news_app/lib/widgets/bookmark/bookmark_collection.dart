import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/screens/layouts/bookmark_detail.dart';
import 'package:news_app/utils/static_utils.dart';

class BookmarkCollection extends StatefulWidget {
  const BookmarkCollection({super.key});

  @override
  State<BookmarkCollection> createState() => _BookmarkCollectionState();
}

class _BookmarkCollectionState extends State<BookmarkCollection> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoaded) {
          if (state.allNews.isEmpty) {
            return Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Text(
                "Your bookmark collection is empty. Add bookmarks",
                style: theme.typography.headlineMedium,
              ),
            ));
          } else {
            List<String> catogries = [];
            for (var news in state.allNews) {
              if (!catogries.contains(news.category)) {
                catogries.add(news.category);
              }
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: catogries.length,
              itemBuilder: (context, index) {
                late String image1;
                late String image2;
                late String image3;
                final String category = catogries[index];
                if (category == 'environment') {
                  image1 = StaticUtils.envinmentImageUrl1;
                  image2 = StaticUtils.envinmentImageUrl2;
                  image3 = StaticUtils.envinmentImageUrl3;
                } else if (category == 'health') {
                  image1 = StaticUtils.healthImageUrl1;
                  image2 = StaticUtils.healthImageUrl2;
                  image3 = StaticUtils.healthImageUrl3;
                } else if (category == 'science') {
                  image1 = StaticUtils.healthImageUrl1;
                  image2 = StaticUtils.healthImageUrl2;
                  image3 = StaticUtils.healthImageUrl3;
                } else if (category == 'business') {
                  image1 = StaticUtils.businessImageUrl1;
                  image2 = StaticUtils.businessImageUrl2;
                  image3 = StaticUtils.businessImageUrl3;
                } else {
                  image1 = StaticUtils.defaultImageUrl;
                  image2 = StaticUtils.defaultImageUrl;
                  image3 = StaticUtils.defaultImageUrl;
                }
                return GestureDetector(
                  onTap: () {
                    List<NewsModel> filterdNews = [];
                    for (var news in state.allNews) {
                      if (news.category == category) {
                        log("New catgory: ${news.category} -------------- Catogory: $category");
                        filterdNews.add(news);
                      }
                    }

                    log(filterdNews.length.toString());
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          BookmarkDetail(news: filterdNews, category: category),
                    ));
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(image1),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10)),
                                    image: DecorationImage(
                                        image:
                                            CachedNetworkImageProvider(image2),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(10)),
                                    image: DecorationImage(
                                        image:
                                            CachedNetworkImageProvider(image3),
                                        fit: BoxFit.cover)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        StaticUtils.capitalize(catogries[index]),
                        style: theme.typography.titleMedium2,
                      )
                    ],
                  ),
                );
              },
            );
          }
        } else if (state is NewsLoading) {
          return StaticUtils.getShimmerEffect(theme);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
