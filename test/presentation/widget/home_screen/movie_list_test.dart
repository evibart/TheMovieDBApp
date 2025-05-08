import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../lib/src/domain/entity/movie_entity.dart';
import '../../../../lib/src/presentation/widget/home_screen/movie_list.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('MovieList displays movies correctly',
      (WidgetTester tester) async {
    final List<MovieEntity> movies = [
      MovieEntity(
        id: 1,
        originalLanguage: 'English',
        originalTitle: 'title',
        popularity: 200,
        releaseDate: '2023-8-9',
        title: 'title',
        hasVideo: false,
        voteCount: 200,
        overview: '',
        voteAverage: 0.0,
        genres: [],
        poster: '',
        backdrop: '',
        isAdult: false,
        categories: [],
      )
    ];

    final movieList = MovieList(moviesList: movies);

    await mockNetworkImagesFor(
        () => tester.pumpWidget(MaterialApp(home: Scaffold(body: movieList))));

    expect(
      find.byType(Card),
      findsNWidgets(movies.length),
    );

    expect(
      find.byType(Image),
      findsOneWidget,
    );
  });
  testWidgets('MovieList is empty', (WidgetTester tester) async {
    final List<MovieEntity> moviesEmpty = [];
    final movieList = MovieList(moviesList: moviesEmpty);

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: movieList)));

    expect(
      find.byType(Card),
      findsNWidgets(moviesEmpty.length),
    );
  });
}
