// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/config/theme/app_theme.dart';
import 'package:news_app/controllers/search/search_cubit.dart';
import 'package:news_app/controllers/search/search_state.dart';
import 'package:news_app/utils/static_utils.dart';

class AddFilterSheet extends StatelessWidget {
  const AddFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            String date = state is SearchWithFilter ? state.date : '';
            List<String> categories = state is SearchWithFilter
                ? List<String>.from(state.category)
                : [];
            List<String> location = state is SearchWithFilter
                ? List<String>.from(state.location)
                : [];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filters',
                  style: theme.typography.headlineMedium,
                ),
                const SizedBox(height: 10),
                Text(
                  'Works only for news',
                  style: theme.typography.titleSmall2,
                ),
                const SizedBox(height: 30),
                Text(
                  'Date range',
                  style: theme.typography.headlineMedium,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.dateFilters.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        fillColor: WidgetStatePropertyAll(theme.secondaryText),
                        title: Text(
                          StaticUtils.capitalize(state.dateFilters[index]),
                          style: theme.typography.headlineSmall2,
                        ),
                        value: state.dateFilters[index],
                        groupValue: date,
                        onChanged: (value) {
                          context
                              .read<SearchCubit>()
                              .searchWithFilter(value!, categories, location);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Category (${categories.length})',
                  style: theme.typography.headlineMedium,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 10.0,
                  children:
                      List.generate(state.categoryFilters.length, (index) {
                    final category = state.categoryFilters[index];
                    return GestureDetector(
                      onTap: () {
                        // log(state.toString());
                        if (categories.contains(category)) {
                          categories.remove(category);
                        } else {
                          categories.add(category);
                        }
                        context
                            .read<SearchCubit>()
                            .searchWithFilter(date, categories, location);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: categories.contains(category)
                              ? Border.all(color: theme.secondaryText)
                              : Border.all(color: theme.primary),
                        ),
                        child: Text(
                          StaticUtils.capitalize(category),
                          style: theme.typography.titleSmall2,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 30),
                Text(
                  'Location (${location.length})',
                  style: theme.typography.headlineMedium,
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 10.0,
                  children:
                      List.generate(state.locationFilters.length, (index) {
                    final loc = state.locationFilters[index];
                    return GestureDetector(
                      onTap: () {
                        // log(state.toString());
                        if (location.contains(loc)) {
                          location.remove(loc);
                        } else {
                          location.add(loc);
                        }
                        context
                            .read<SearchCubit>()
                            .searchWithFilter(date, categories, location);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: location.contains(loc)
                              ? Border.all(color: theme.secondaryText)
                              : Border.all(color: theme.primary),
                        ),
                        child: Text(
                          StaticUtils.capitalize(loc),
                          style: theme.typography.titleSmall2,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          date = '';
                          categories.clear();
                          location.clear();
                          context.read<SearchCubit>().removeAllFilters();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 45,
                          child: Center(
                            child: Text(
                              'Reset',
                              style: theme.typography.titleMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (state is SearchWithFilter) {
                            context
                                .read<SearchCubit>()
                                .searchWithFilter(date, categories, location);
                          }

                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.info,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 45,
                          child: Center(
                            child: Text(
                              'Done',
                              style: theme.typography.labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
