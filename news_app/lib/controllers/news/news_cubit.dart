import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_services.dart';

// a class for manageing all incomeing news data from firbase

class NewsCubit extends Cubit<NewsState> {
  final NewsServices newsServices;
  NewsCubit({required this.newsServices}) : super(NewsInitial());

  void fetchAllNews() async {
    emit(NewsLoading());
    try {
      final List<NewsModel> allnews = await newsServices.getAllNews();
      final List<NewsModel> yourNews = await newsServices.getYourNews();
      final List<NewsModel> bookMarkedNews =
          await newsServices.getBookmarkedNews();
      emit(NewsLoaded(
          allNews: allnews,
          yourNews: yourNews,
          bookmarkedNews: bookMarkedNews));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
