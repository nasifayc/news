import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/search/search_cubit.dart';
import 'package:news_app/controllers/search/search_state.dart';
import 'package:news_app/utils/static_utils.dart';
import 'package:news_app/widgets/layouts/search/add_filter_sheet.dart';

class FilterCard extends StatefulWidget {
  const FilterCard({super.key});

  @override
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    void showFilterPage() {
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
          padding: MediaQuery.of(context).viewInsets,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white),
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: const AddFilterSheet()),
        ),
      );
    }

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchWithFilter) {
          final List<String> allFilters = [
            ...state.category,
            ...state.location
          ];
          if (state.date.isNotEmpty || state.date != '') {
            allFilters.insert(0, state.date);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8.0,
                runSpacing: 10.0,
                children: List.generate(allFilters.length, (index) {
                  final filter = allFilters[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      border: Border.all(color: theme.primary),
                    ),
                    child: Text(
                      StaticUtils.capitalize(filter),
                      style: theme.typography.titleSmall2,
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: showFilterPage,
                  child: Container(
                    height: 39,
                    width: 102,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.secondaryText.withOpacity(0.2)),
                    child: Center(
                        child: Text(
                      'Add Filter',
                      style: TextStyle(
                          color: theme.secondaryText,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                  ))
            ],
          );
        }
        return Text(
          'Error',
          style: theme.typography.headlineMedium,
        );
      },
    );
  }
}
