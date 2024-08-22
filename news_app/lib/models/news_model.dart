import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final String id;
  final String category;
  final String title;
  final String description;
  final DateTime createdDate;
  final String imageUrl;
  final String location;
  final String author;

  const NewsModel(
      {required this.id,
      required this.category,
      required this.title,
      required this.description,
      required this.createdDate,
      required this.imageUrl,
      required this.location,
      required this.author});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'createdDate': createdDate.toIso8601String(),
      'imageUrl': imageUrl,
      'location': location,
      'author': author
    };
  }

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      createdDate: (json['createdDate'] as Timestamp).toDate(),
      imageUrl: json['imageUrl'],
      location: json['location'],
      author: json['author'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        category,
        title,
        description,
        createdDate,
        imageUrl,
        location,
        author,
      ];
}
