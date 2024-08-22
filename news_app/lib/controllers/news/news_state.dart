import 'package:equatable/equatable.dart';
import 'package:news_app/models/news_model.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object> get props => [];
}

final class NewsInitial extends NewsState {}

final class NewsLoading extends NewsState {}

final class NewsError extends NewsState {
  final String error;

  NewsError(this.error);

  @override
  List<Object> get props => [error];
}

final class NewsLoaded extends NewsState {
  final List<NewsModel> allNews;
  final List<NewsModel> yourNews;
  final List<NewsModel> bookmarkedNews;

  NewsLoaded({
    required this.allNews,
    required this.yourNews,
    required this.bookmarkedNews,
  });

  @override
  List<Object> get props => [allNews, yourNews, bookmarkedNews];
}
