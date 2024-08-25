import 'package:flutter/material.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/widgets/bookmark/bookmark_bar.dart';
import 'package:news_app/widgets/bookmark/bookmark_collection.dart';
import 'package:news_app/widgets/common/custome_form_fields.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // AppTheme theme = AppTheme.of(context);
    CustomFormComponents formComponents =
        CustomFormComponents(context: context);
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BookmarkBar(),
          const SizedBox(
            height: 20,
          ),
          formComponents.buildSearchBar(
              _searchController, "Search “Collection”", false),
          const SizedBox(
            height: 20,
          ),
          const Expanded(child: BookmarkCollection())
        ],
      ),
    ));
  }
}
