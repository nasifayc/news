import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/common/custome_form_fields.dart';
import 'package:news_app/widgets/layouts/profiles_detail/agent_profile.dart';

class AgentNews extends StatelessWidget {
  final List<NewsModel> newslist;
  final UserModel user;
  const AgentNews({super.key, required this.newslist, required this.user});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    AppTheme theme = AppTheme.of(context);
    CustomFormComponents formComponents =
        CustomFormComponents(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          'News by ${StaticUtils.capitalize(user.username)}',
          style: theme.typography.titleMedium2,
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
        formComponents.buildSearchBar(searchController, 'Search “News”', false),
        const SizedBox(
          height: 20,
        ),
        newslist.isEmpty
            ? Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Text(
                      "${user.username} hasn't posted yet.",
                      style: theme.typography.titleSmall2,
                    )),
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newslist.length,
                itemBuilder: (context, index) {
                  NewsModel news = newslist[index];
                  return Column(
                    children: [
                      AgentProfile(
                        news: news,
                        user: user,
                      ),
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
}
