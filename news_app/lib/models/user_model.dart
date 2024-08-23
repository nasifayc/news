import 'package:equatable/equatable.dart';
import 'package:news_app/models/bookmark.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? photo;
  final String id;
  final String email;
  String? password;
  String? bio;
  final String username;
  final List<BookMark> bookmarks;
  List<String> followers;
  List<String> following;
  List<String> news;
  bool isVerfied;

  UserModel({
    required this.id,
    required this.email,
    this.password,
    this.bio,
    required this.username,
    this.photo,
    this.bookmarks = const [],
    this.followers = const [],
    this.following = const [],
    this.news = const [],
    this.isVerfied = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
      'id': id,
      'email': email,
      'bio': bio,
      'username': username,
      'bookmarks': bookmarks.map((bookmark) => bookmark.toJson()).toList(),
      'followers': followers,
      'following': following,
      'news': news,
      'isVerified': isVerfied,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      bio: json['bio'],
      username: json['username'],
      photo: json['photo'],
      bookmarks: (json['bookmarks'] as List<dynamic>?)
              ?.map((item) => BookMark.fromJson(item))
              .toList() ??
          [],
      followers: (json['followers'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      following: (json['following'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      news: (json['news'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      isVerfied: json['isVerified'],
    );
  }

  @override
  List<Object?> get props => [
        photo,
        id,
        email,
        bio,
        password,
        username,
        bookmarks,
        followers,
        following,
        news,
        isVerfied,
      ];
}
