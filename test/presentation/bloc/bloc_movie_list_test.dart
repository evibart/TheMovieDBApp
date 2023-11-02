import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_db_app/src/data/datasource/local/app_database.dart';
import 'package:movie_db_app/src/data/repository/movie_database_repository.dart';
import '../../../lib/src/domain/use_case/implementation/movie_use_case.dart';
import '../../../lib/src/core/util/movie_enum.dart';
import '../../../lib/src/data/datasource/remote/api_service.dart';
import '../../../lib/src/data/repository/movie_remote_repository.dart';
import '../../../lib/src/domain/entity/movie_entity.dart';
import '../../../lib/src/presentation/bloc/movie_bloc.dart';

class MockMoviesUseCase extends Mock implements MovieUseCase {}

class MockDatabaseGenreRepository extends Mock implements AppDataBase {}

void main() async {
  group('bloc movie testing', () {
    late MovieBloc _blocMovieList;
    setUp(() {
      MovieRemoteRepository movieRemoteRepository =
          MovieRemoteRepository(apiService: ApiService());
      _blocMovieList = MovieBloc(
        moviesUseCase: MovieUseCase(
            movieRepository: movieRemoteRepository,
            movieDataBase: MovieDatabaseRepository(
                appDataBase: MockDatabaseGenreRepository())),
      );
    });
    test('fetch popular Movies adds movies to stream correctly', () async {
      _blocMovieList.fetchMovies(MovieEndpoint.popular);
      _blocMovieList.allMovies.listen(expectAsync1((value) {
        expect(
          value,
          isInstanceOf<List<MovieEntity>>(),
        );
      }));
    });
    test('fetch top rated Movies adds movies to stream correctly', () async {
      _blocMovieList.fetchMovies(MovieEndpoint.topRated);
      _blocMovieList.allMovies.listen(expectAsync1((value) {
        expect(
          value,
          isInstanceOf<List<MovieEntity>>(),
        );
      }));
    });
    test('fetch up-coming Movies adds movies to stream correctly', () async {
      _blocMovieList.fetchMovies(MovieEndpoint.upComing);
      _blocMovieList.allMovies.listen(expectAsync1((value) {
        expect(
          value,
          isInstanceOf<List<MovieEntity>>(),
        );
      }));
    });
    test('fetch now playing Movies adds movies to stream correctly', () async {
      _blocMovieList.fetchMovies(MovieEndpoint.nowPlaying);
      _blocMovieList.allMovies.listen(expectAsync1((value) {
        expect(
          value,
          isInstanceOf<List<MovieEntity>>(),
        );
      }));
    });
  });
  group('BlocMovieList', () {
    late MovieBloc blocMovieList;

    late MockMoviesUseCase mockMoviesUseCase;

    setUp(() {
      mockMoviesUseCase = MockMoviesUseCase();

      blocMovieList = MovieBloc(moviesUseCase: mockMoviesUseCase);
    });

    test('fetchMovies fetches popular movies correctly', () async {
      final mockMovies = [
        MovieEntity(
          title: "The Super Mario Bros. Movie",
          originalTitle: "The Super Mario Bros. Movie",
          overview: "While working underground to fix a "
              "water main, Brooklyn plumbers—and brothers—Mario and Luigi are "
              "transported down a mysterious pipe and wander into a magical new "
              "world. But when the brothers are separated, Mario embarks on an epic "
              "quest to find Luigi.",
          releaseDate: '2023-4-5',
          voteAverage: 7.8,
          genres: [
            16,
            10751,
            12,
            14,
            35,
          ],
          poster: 'movie_images/poster.jpg',
          backdrop: 'movie_images/backdrop.jpg',
          originalLanguage: 'en',
          popularity: 3000.3,
          hasVideo: false,
          voteCount: 300,
          isAdult: false,
          id: -1,
          categories: [],
        )
      ];

      when(() =>
              mockMoviesUseCase.execute(movieEndpoint: MovieEndpoint.popular))
          .thenAnswer(
        (_) async => Right<Exception, List<MovieEntity>>(mockMovies),
      );

      blocMovieList.fetchMovies(MovieEndpoint.popular);

      await expectLater(
        blocMovieList.allMovies,
        emitsInOrder([mockMovies]),
      );
    });
    test('fetchMovies fetches empty popular movies correctly', () async {
      when(() =>
              mockMoviesUseCase.execute(movieEndpoint: MovieEndpoint.popular))
          .thenAnswer(
        (_) async => Right<Exception, List<MovieEntity>>([]),
      );
      blocMovieList.fetchMovies(MovieEndpoint.popular);
      await expectLater(
        blocMovieList.allMovies,
        emitsInOrder([]),
      );
    });
    test('fetchMovies fetches error', () async {
      when(() =>
              mockMoviesUseCase.execute(movieEndpoint: MovieEndpoint.popular))
          .thenAnswer(
        (_) async => Left<Exception, List<MovieEntity>>(Exception('Error 404')),
      );
      blocMovieList.fetchMovies(MovieEndpoint.popular);
      await expectLater(
        blocMovieList.allMovies,
        emitsError('Error 404'),
      );
    });
    tearDown(() {
      blocMovieList.dispose();
    });
  });
}
