import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/data/model/data_state.dart';
import '../../../lib/src/domain/repository/movie_database_repository_i.dart';
import '../../../lib/src/core/util/movie_enum.dart';
import '../../../lib/src/domain/use_case/implementation/movie_use_case.dart';
import '../../../lib/src/domain/use_case/movie_use_case_i.dart';
import '../../../lib/src/domain/entity/movie_entity.dart';
import '../../../lib/src/domain/repository/movie_repository_i.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

class MockMovieDataBase extends Mock implements IMovieDatabaseRepository {}

void main() {
  group('Now playing movies List UseCase', () {
    late MovieUseCaseI movieListUseCase;
    late MockMovieRepository mockMovieRepository;
    late MockMovieDataBase mockMovieDataBase;
    setUp(() {
      mockMovieRepository = MockMovieRepository();
      mockMovieDataBase = MockMovieDataBase();
      movieListUseCase = MovieUseCase(
        movieRepository: mockMovieRepository,
        movieDataBase: mockMovieDataBase,
      );
    });

    test('load returns a list of movies on success', () async {
      when(() => mockMovieRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular)).thenAnswer(
        (_) async => DataSuccess<List<MovieEntity>>([
          MovieEntity(
            title: "The Super Mario Bros. Movie",
            originalTitle: "The Super Mario Bros. Movie",
            overview: "While working underground to fix a "
                "water main, Brooklyn plumbers—and brothers—Mario and Luigi are "
                "transported down a mysterious pipe and wander into a magical new "
                "world. But when the brothers are separated, Mario embarks on an epic "
                "quest to find Luigi.",
            releaseDate: '2023-4-5-',
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
        ]),
      );

      final result =
          await movieListUseCase.execute(movieEndpoint: MovieEndpoint.popular);

      expect(
        result,
        isA<Right<String, List<MovieEntity>>>(),
      );

      expect(
        result.data,
        [
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
        ],
      );
    });
    test('execute returns an empty list of movies on success', () async {
      when(() => mockMovieRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular)).thenAnswer(
        (_) async => DataSuccess<List<MovieEntity>>([]),
      );

      final result =
          await movieListUseCase.execute(movieEndpoint: MovieEndpoint.popular);

      expect(
        result,
        isA<DataSuccess>,
      );

      expect(
        result.data,
        [],
      );
    });
    test('execute returns an error on failure', () async {
      when(() => mockMovieRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular)).thenAnswer(
        (_) async => DataFailure<List<MovieEntity>>(Exception('Error 404')),
      );

      final result =
          await movieListUseCase.execute(movieEndpoint: MovieEndpoint.popular);

      expect(result, isA<DataFailure>);
      expect(
        result.error.toString(),
        'Error 404',
      );
    });
  });
}
