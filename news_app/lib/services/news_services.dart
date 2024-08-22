import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/models/bookmark.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<NewsModel>> getAllNews() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firestore.collection('news').get();

    List<NewsModel> allNews = [];

    for (var docSnapshot in querySnapshot.docs) {
      List<dynamic> newsList = docSnapshot.data()['news'] ?? [];

      List<NewsModel> newsModels = newsList.map((newsItem) {
        return NewsModel.fromJson(newsItem as Map<String, dynamic>);
      }).toList();

      allNews.addAll(newsModels);
    }

    return allNews;
  }

  Future<List<NewsModel>> getYourNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      return [];
    }

    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await _firestore.collection('news').doc(userId).get();

    if (!docSnapshot.exists) {
      return [];
    }

    List<dynamic> newsList = docSnapshot.data()?['news'] ?? [];

    List<NewsModel> yourNews = newsList.map((newsItem) {
      return NewsModel.fromJson(newsItem as Map<String, dynamic>);
    }).toList();

    return yourNews;
  }

  Future<List<NewsModel>> getBookmarkedNews() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      return [];
    }

    // Fetch the user document
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (!userDoc.exists) {
      return [];
    }

    UserModel user = UserModel.fromJson(userDoc.data()!);

    List<NewsModel> bookmarkedNews = [];

    // Iterate over the bookmarks and fetch the news
    for (BookMark bookmark in user.bookmarks) {
      DocumentSnapshot<Map<String, dynamic>> newsDoc =
          await _firestore.collection('news').doc(bookmark.authorId).get();

      if (newsDoc.exists) {
        List<dynamic> newsList = newsDoc.data()?['news'] ?? [];

        for (var newsItem in newsList) {
          NewsModel newsModel = NewsModel.fromJson(newsItem);
          if (newsModel.id == bookmark.newsId) {
            bookmarkedNews.add(newsModel);
          }
        }
      }
    }

    return bookmarkedNews;
  }
}
