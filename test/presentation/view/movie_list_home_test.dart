import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/domain/entity/movie_entity.dart';
import '../../../lib/src/presentation/bloc/movie_bloc.dart';
import '../../../lib/src/presentation/view/movie_list_home.dart';
import '../../../lib/src/presentation/widget/home_screen/movie_list.dart';
import 'package:network_image_mock/network_image_mock.dart';

class MockBlocMovieList extends Mock implements MovieBloc {}

void main() {
  late MockBlocMovieList mockBlocMovieList;
  setUp(() {
    mockBlocMovieList = MockBlocMovieList();
  });

  testWidgets('movies widget test', (WidgetTester tester) async {
    final List<MovieEntity> movies = [
      MovieEntity(
        id: 1,
        originalLanguage: 'English',
        originalTitle: 'title',
        popularity: 200,
        releaseDate: DateTime(
          2023,
          8,
          9,
        ),
        title: 'title',
        hasVideo: false,
        voteCount: 200,
        overview: '',
        voteAverage: 0.0,
        genres: [],
        poster: '',
        backdrop: '',
        isAdult: false,
      ),
    ];
    await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
          home: MovieList(moviesList: movies),
        )));
    await tester.pumpAndSettle();

    expect(
      find.byKey(Key('GridViewBuild')),
      findsOneWidget,
    );
  });

  testWidgets('Drawer should open and show items', (WidgetTester tester) async {
    when(() => mockBlocMovieList.allMovies).thenAnswer(
      (_) => Stream<List<MovieEntity>>.empty(),
    );
    await tester.pumpWidget(MaterialApp(
      home: MovieListHome(
        movieBloc: mockBlocMovieList,
      ),
    ));

    final drawerIcon = find.byIcon(Icons.menu);
    await tester.tap(drawerIcon);

    await tester.pumpAndSettle();

    expect(
      find.text('Movies'),
      findsOneWidget,
    );
    expect(
      find.byKey(Key('PopularDrawer')),
      findsOneWidget,
    );
    expect(
      find.byKey(Key('TopRatedDrawer')),
      findsOneWidget,
    );
    expect(
      find.byKey(Key('NowPlayingDrawer')),
      findsOneWidget,
    );
    expect(
      find.byKey(Key('UpComingDrawer')),
      findsOneWidget,
    );

    Navigator.pop(tester.element(find.text('Movies')));

    await tester.pumpAndSettle();

    expect(
      find.text('Movies'),
      findsNothing,
    );
  });
  testWidgets('MovieListHome displays loading indicator',
      (WidgetTester tester) async {
    when(() => mockBlocMovieList.allMovies).thenAnswer(
      (_) => Stream<List<MovieEntity>>.empty(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MovieListHome(movieBloc: mockBlocMovieList),
      ),
    );

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
  });

  testWidgets('MovieListHome displays error message',
      (WidgetTester tester) async {
    final errorMessage = 'Error fetching movies';

    when(() => mockBlocMovieList.allMovies).thenAnswer(
      (_) => Stream.error(errorMessage),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MovieListHome(movieBloc: mockBlocMovieList),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(errorMessage),
      findsOneWidget,
    );
  });
}
