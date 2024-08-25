// Corrected instantiation with all required fields
import 'package:news_app/models/news_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:news_app/controllers/news/news_cubit.dart';
import 'package:news_app/controllers/news/news_state.dart';
import 'package:news_app/services/news_services.dart';
import 'package:mocktail/mocktail.dart';

final newsModel1 = NewsModel(
  id: '1',
  category: 'Category1',
  title: 'News 1',
  description: 'Description of News 1',
  createdDate: DateTime.now(),
  imageUrl: 'https://example.com/image1.jpg',
  location: 'Location1',
  author: 'Author1',
);

final newsModel2 = NewsModel(
  id: '2',
  category: 'Category2',
  title: 'Your News',
  description: 'Description of Your News',
  createdDate: DateTime.now(),
  imageUrl: 'https://example.com/image2.jpg',
  location: 'Location2',
  author: 'Author2',
);

final newsModel3 = NewsModel(
  id: '3',
  category: 'Category3',
  title: 'Bookmarked News',
  description: 'Description of Bookmarked News',
  createdDate: DateTime.now(),
  imageUrl: 'https://example.com/image3.jpg',
  location: 'Location3',
  author: 'Author3',
);

class MockNewsServices extends Mock implements NewsServices {}

void main() {
  late NewsServices mockNewsServices;
  late NewsCubit newsCubit;

  setUp(() {
    mockNewsServices = MockNewsServices();
    newsCubit = NewsCubit(newsServices: mockNewsServices);
  });

  test('initial state is NewsInitial', () {
    expect(newsCubit.state, equals(NewsInitial()));
  });

  blocTest<NewsCubit, NewsState>(
    'emits [NewsLoading, NewsLoaded] when fetchAllNews is successful',
    build: () {
      when(() => mockNewsServices.getAllNews()).thenAnswer((_) async => [
            NewsModel(
              id: '1',
              category: 'Category1',
              title: 'News 1',
              description: 'Description of News 1',
              createdDate: DateTime.now(),
              imageUrl: 'https://example.com/image1.jpg',
              location: 'Location1',
              author: 'Author1',
            )
          ]);
      when(() => mockNewsServices.getYourNews()).thenAnswer((_) async => [
            NewsModel(
              id: '2',
              category: 'Category2',
              title: 'Your News',
              description: 'Description of Your News',
              createdDate: DateTime.now(),
              imageUrl: 'https://example.com/image2.jpg',
              location: 'Location2',
              author: 'Author2',
            )
          ]);
      when(() => mockNewsServices.getBookmarkedNews()).thenAnswer((_) async => [
            NewsModel(
              id: '3',
              category: 'Category3',
              title: 'Bookmarked News',
              description: 'Description of Bookmarked News',
              createdDate: DateTime.now(),
              imageUrl: 'https://example.com/image3.jpg',
              location: 'Location3',
              author: 'Author3',
            )
          ]);
      return newsCubit;
    },
    act: (cubit) => cubit.fetchAllNews(),
    expect: () => [
      NewsLoading(),
      NewsLoaded(
        allNews: [
          NewsModel(
            id: '1',
            category: 'Category1',
            title: 'News 1',
            description: 'Description of News 1',
            createdDate: DateTime.now(),
            imageUrl: 'https://example.com/image1.jpg',
            location: 'Location1',
            author: 'Author1',
          )
        ],
        yourNews: [
          NewsModel(
            id: '2',
            category: 'Category2',
            title: 'Your News',
            description: 'Description of Your News',
            createdDate: DateTime.now(),
            imageUrl: 'https://example.com/image2.jpg',
            location: 'Location2',
            author: 'Author2',
          )
        ],
        bookmarkedNews: [
          NewsModel(
            id: '3',
            category: 'Category3',
            title: 'Bookmarked News',
            description: 'Description of Bookmarked News',
            createdDate: DateTime.now(),
            imageUrl: 'https://example.com/image3.jpg',
            location: 'Location3',
            author: 'Author3',
          )
        ],
      ),
    ],
  );

  blocTest<NewsCubit, NewsState>(
    'emits [NewsLoading, NewsError] when fetchAllNews fails',
    build: () {
      when(() => mockNewsServices.getAllNews())
          .thenThrow(Exception('Failed to load news'));
      when(() => mockNewsServices.getYourNews())
          .thenThrow(Exception('Failed to load your news'));
      when(() => mockNewsServices.getBookmarkedNews())
          .thenThrow(Exception('Failed to load bookmarked news'));
      return newsCubit;
    },
    act: (cubit) => cubit.fetchAllNews(),
    expect: () => [
      NewsLoading(),
      NewsError('Exception: Failed to load news'),
    ],
  );
}
