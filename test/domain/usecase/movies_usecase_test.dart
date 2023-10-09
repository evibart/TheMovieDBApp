import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/core/util/movie_enum.dart';
import '../../../lib/src/domain/use_case/implementation/movie_use_case.dart';
import '../../../lib/src/domain/use_case/movie_use_case_i.dart';
import '../../../lib/src/domain/entity/movie_entity.dart';
import '../../../lib/src/domain/repository/movie_repository_i.dart';

class MockMovieRepository extends Mock implements IMovieRepository {}

void main() {
  group('Now playing movies List UseCase', () {
    late MovieUseCaseI movieListUseCase;
    late MockMovieRepository mockMovieRepository;

    setUp(() {
      mockMovieRepository = MockMovieRepository();
      movieListUseCase = MovieUseCase(movieRepository: mockMovieRepository);
    });

    test('load returns a list of movies on success', () async {
      when(() => mockMovieRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular)).thenAnswer(
        (_) async => Right<String, List<MovieEntity>>([
          MovieEntity(
            title: "The Super Mario Bros. Movie",
            originalTitle: "The Super Mario Bros. Movie",
            overview: "While working underground to fix a "
                "water main, Brooklyn plumbers—and brothers—Mario and Luigi are "
                "transported down a mysterious pipe and wander into a magical new "
                "world. But when the brothers are separated, Mario embarks on an epic "
                "quest to find Luigi.",
            releaseDate: DateTime(
              2023,
              4,
              5,
            ),
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
          )
        ]),
      );

      final result =
          await movieListUseCase.execute(movieEndpoint: MovieEndpoint.popular);

      expect(result, isA<Right<String, List<MovieEntity>>>());
      result.fold(
        (error) {
          fail('Expected success, but got error: $error');
        },
        (movies) {
          expect(
            movies,
            [
              MovieEntity(
                title: "The Super Mario Bros. Movie",
                originalTitle: "The Super Mario Bros. Movie",
                overview: "While working underground to fix a "
                    "water main, Brooklyn plumbers—and brothers—Mario and Luigi are "
                    "transported down a mysterious pipe and wander into a magical new "
                    "world. But when the brothers are separated, Mario embarks on an epic "
                    "quest to find Luigi.",
                releaseDate: DateTime(
                  2023,
                  4,
                  5,
                ),
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
              )
            ],
          );
        },
      );
    });
    test('execute returns an empty list of movies on success', () async {
      when(() => mockMovieRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular)).thenAnswer(
        (_) async => Right<String, List<MovieEntity>>([]),
      );

      final result =
          await movieListUseCase.execute(movieEndpoint: MovieEndpoint.popular);

      expect(
        result,
        isA<Right<String, List<MovieEntity>>>(),
      );
      result.fold(
        (error) {
          fail('Expected success, but got error: $error');
        },
        (movies) {
          expect(
            movies,
            [],
          );
        },
      );
    });
    test('execute returns an error on failure', () async {
      when(() => mockMovieRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular)).thenAnswer(
        (_) async => Left<String, List<MovieEntity>>('Error 404'),
      );

      final result =
          await movieListUseCase.execute(movieEndpoint: MovieEndpoint.popular);

      expect(result, isA<Left<String, List<MovieEntity>>>());
      expect(
        result.fold((error) => error, (_) => ''),
        'Error 404',
      );
    });
  });
}
