import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controllers/search/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchWithFilter());

  void searchWithFilter(String dateFilter, List<String> categoryFilter,
      List<String> locationFilter) {
    // if (dateFilter == null ||
    //     categoryFilter.isEmpty ||
    //     locationFilter.isEmpty) {
    //   return;
    // }

    emit(SearchWithFilter(
        date: dateFilter, category: categoryFilter, location: locationFilter));
  }

  void removeAllFilters() {
    emit(SearchInitial());
    emit(SearchWithFilter());
  }

  void toggleDate(String date) {
    final currentState = state;
    if (currentState is SearchWithFilter) {
      emit(SearchWithFilter(
        date: date,
        category: currentState.category,
        location: currentState.location,
      ));
    }
  }

  void toggleCategory(String category) {
    final currentState = state;
    if (currentState is SearchWithFilter) {
      final updatedCategories = List<String>.from(currentState.category);
      if (updatedCategories.contains(category)) {
        updatedCategories.remove(category);
      } else {
        updatedCategories.add(category);
      }
      emit(SearchWithFilter(
        date: currentState.date,
        category: updatedCategories,
        location: currentState.location,
      ));
    }
  }

  void toggleLocation(String location) {
    final currentState = state;
    if (currentState is SearchWithFilter) {
      final updatedLocations = List<String>.from(currentState.location);
      if (updatedLocations.contains(location)) {
        updatedLocations.remove(location);
      } else {
        updatedLocations.add(location);
      }
      emit(SearchWithFilter(
        date: currentState.date,
        category: currentState.category,
        location: updatedLocations,
      ));
    }
  }
}
