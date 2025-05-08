import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../lib/src/core/util/status.dart';
import '../../../../lib/src/domain/entity/data.dart';
import '../../../../lib/src/domain/entity/genre_entity.dart';
import '../../../../lib/src/presentation/bloc/genre_bloc.dart';
import '../../../../lib/src/presentation/widget/movie_info_screen/movie_genres.dart';

class MockBlocGenreList extends Mock implements GenreBloc {}

void main() {
  late MovieGenres movieGenres;
  late MockBlocGenreList mockBlocGenreList;

  setUp(() {
    mockBlocGenreList = MockBlocGenreList();
    movieGenres = MovieGenres(
      movieGenres: [
        1,
        2,
        3,
      ],
      blocGenreList: mockBlocGenreList,
    );
  });
  testWidgets('Renders CircularProgressIndicator when loading',
      (WidgetTester tester) async {
    when(() => mockBlocGenreList.allGenres).thenAnswer(
      (_) => Stream<Data<List<GenreEntity>>>.empty(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MovieGenres(
          movieGenres: [
            1,
            2,
          ],
          blocGenreList: mockBlocGenreList,
        ),
      ),
    );

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });

  testWidgets('Renders error message when there is an error',
      (WidgetTester tester) async {
    when(() => mockBlocGenreList.allGenres)
        .thenAnswer((_) => Stream.error('Error'));

    await tester.pumpWidget(
      MaterialApp(
        home: MovieGenres(
          movieGenres: [
            1,
            2,
          ],
          blocGenreList: mockBlocGenreList,
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.widgetWithText(
        MovieGenres,
        'Error',
      ),
      findsOneWidget,
    );
  });

  testWidgets('MovieGenres widget test', (WidgetTester tester) async {
    when(() => mockBlocGenreList.allGenres).thenAnswer(
      (_) => Stream.value(Data(
        state: Status.success,
        actualData: [
          GenreEntity(
            id: 1,
            name: 'Action',
          ),
          GenreEntity(
            id: 2,
            name: 'Drama',
          ),
          GenreEntity(
            id: 3,
            name: 'Comedy',
          ),
          GenreEntity(
            id: 4,
            name: 'Adventure',
          ),
        ],
      )),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: movieGenres,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Action'),
      findsOneWidget,
    );
    expect(
      find.text('Drama'),
      findsOneWidget,
    );
    expect(
      find.text('Comedy'),
      findsOneWidget,
    );

    expect(
      find.text('Adventure'),
      findsNothing,
    );
  });
}
