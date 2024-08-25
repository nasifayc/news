import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/common/custome_form_fields.dart';
import 'package:news_app/widgets/layouts/search/searched_news_card.dart';
import 'package:news_app/widgets/profile/profile_news_card.dart';

class SearchedNews extends StatelessWidget {
  const SearchedNews({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    CustomFormComponents formComponents =
        CustomFormComponents(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text(
                'News',
                style: theme.typography.titleLarge2,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Publisher',
                style: TextStyle(
                    color: theme.accent2,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoaded) {
              List<NewsModel> allNews = state.allNews;
              if (allNews.isEmpty) {
                return Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        "No Result.",
                        style: theme.typography.titleSmall2,
                      )),
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${allNews.length} Results found: ',
                            style: theme.typography.titleSmall2,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Row(
                              children: [
                                Text('Sort By: ',
                                    style: theme.typography.titleSmall),
                                Expanded(
                                  child: formComponents.buildDropdownInputField(
                                      null,
                                      [
                                        'Newest',
                                        'Oldest',
                                        'Popular',
                                      ],
                                      'Newest',
                                      (value) {}),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: allNews.length,
                      itemBuilder: (context, index) {
                        NewsModel news = allNews[index];
                        return Column(
                          children: [
                            SearchedNewsCard(newsModel: news),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      },
                    ),
                  ],
                );
              }
            } else if (state is NewsLoading) {
              return StaticUtils.getShimmerEffect(theme);
            }

            return const Text("Unknown Error: ");
          },
        )
      ],
    );
  }
}
