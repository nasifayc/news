import 'dart:core';

import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  final List<String> dateFilters = ['today', 'this week', 'this month'];
  final List<String> categoryFilters = [
    'business',
    'politics',
    'life style',
    'art',
    'health',
    'tech',
    'travel',
    'fashion',
    'sport',
    'food',
    'world',
    'science'
  ];
  final List<String> locationFilters = [
    'global',
    'north america',
    'europe',
    'asia',
    'africa',
    'australia',
    'south america'
  ];

  @override
  List<Object> get props => [dateFilters, categoryFilters, locationFilters];
}

final class SearchInitial extends SearchState {
  // List<String>
}

// ignore: must_be_immutable
final class SearchWithFilter extends SearchState {
  String date;
  final List<String> category;
  final List<String> location;

  SearchWithFilter(
      {this.date = '', this.category = const [], this.location = const []});

  @override
  List<Object> get props => [super.props, date, category, location];
}
