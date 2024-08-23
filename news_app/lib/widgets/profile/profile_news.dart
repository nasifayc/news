import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/common/custome_form_fields.dart';
import 'package:news_app/widgets/profile/profile_news_card.dart';

class ProfileNews extends StatelessWidget {
  const ProfileNews({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    CustomFormComponents formComponents =
        CustomFormComponents(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your news',
          style: theme.typography.titleLarge2,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Text('Sort By: ', style: theme.typography.titleSmall)),
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
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoaded) {
              List<NewsModel> yournews = state.yourNews;
              if (yournews.isEmpty) {
                return Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 100),
                      child: Text(
                        "You don't have any news, make some.",
                        style: theme.typography.titleSmall2,
                      )),
                );
              } else {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: yournews.length,
                  itemBuilder: (context, index) {
                    NewsModel news = yournews[index];
                    return Column(
                      children: [
                        ProfileNewsCard(news: news),
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
            }

            return const Text("Unknown Error: ");
          },
        )
      ],
    );
  }
}
