import 'package:equatable/equatable.dart';

class BookMark extends Equatable {
  final String authorId;
  final String newsId;

  const BookMark({required this.authorId, required this.newsId});

  factory BookMark.fromJson(Map<String, dynamic> json) {
    return BookMark(
      authorId: json['author_id'],
      newsId: json['news_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author_id': authorId,
      'news_id': newsId,
    };
  }

  @override
  List<Object?> get props => [
        authorId,
        newsId,
      ];
}
