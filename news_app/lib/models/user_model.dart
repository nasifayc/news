import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? photo;
  final String id;
  final String email;
  String? password;
  final String username;
  final List<String> bookmarks;
  List<String> followers;
  List<String> following;
  List<String> news;
  bool isVerfied;

  UserModel(
      {required this.id,
      required this.email,
      this.password,
      required this.username,
      this.photo,
      this.bookmarks = const [],
      this.followers = const [],
      this.following = const [],
      this.news = const [],
      this.isVerfied = false});

  Map<String, dynamic> toJson() {
    return {
      'photo': photo,
      'id': id,
      'email': email,
      'username': username,
      'bookmarks': bookmarks,
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
      username: json['username'],
      photo: json['photo'],
      bookmarks: json['bookmarks'] as List<String>,
      followers: json['followers'] as List<String>,
      following: json['following'] as List<String>,
      news: json['news'] as List<String>,
      isVerfied: json['isVerified'],
    );
  }

  @override
  List<Object?> get props => [
        photo,
        id,
        email,
        password,
        username,
        bookmarks,
        followers,
        following,
        news,
        isVerfied,
      ];
}
