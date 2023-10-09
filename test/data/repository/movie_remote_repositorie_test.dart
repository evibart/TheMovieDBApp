import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/core/util/movie_enum.dart';
import '../../../lib/src/data/datasource/remote/api_service.dart';
import '../../../lib/src/data/repository/movie_remote_repository.dart';
import '../../../lib/src/domain/entity/movie_entity.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('MovieRemoteRepository', () {
    late MovieRemoteRepository movieRemoteRepository;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      movieRemoteRepository = MovieRemoteRepository(apiService: mockApiService);
    });

    test('load Popular Movies returns a list of movies on success', () async {
      final List<MovieEntity> movieData = [
        MovieEntity(
          isAdult: false,
          backdrop: "/xFYpUmB01nswPgbzi8EOCT1ZYFu.jpg",
          genres: [28, 18, 12],
          id: 980489,
          originalLanguage: "en",
          originalTitle: "Gran Turismo",
          overview:
              "The ultimate wish-fulfillment tale of a teenage Gran Turismo player whose gaming skills won him a series of Nissan competitions to become an actual professional racecar driver.",
          popularity: 3389.624,
          poster: "/51tqzRtKMMZEYUpSYkrUE7v9ehm.jpg",
          releaseDate: DateTime(
            2023,
            08,
            09,
          ),
          title: "Gran Turismo",
          hasVideo: false,
          voteAverage: 8,
          voteCount: 763,
        )
      ];

      when(() => mockApiService
              .getMovies('https://api.themoviedb.org/3/movie/popular'))
          .thenAnswer((_) async => Right(movieData));

      final result = await movieRemoteRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular);

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
            [
              MovieEntity(
                id: 980489,
                title: "Gran Turismo",
                originalTitle: "Gran Turismo",
                overview:
                    "The ultimate wish-fulfillment tale of a teenage Gran Turismo player whose gaming skills won him a series of Nissan competitions to become an actual professional racecar driver.",
                releaseDate: DateTime(
                  2023,
                  8,
                  9,
                ),
                voteAverage: 8,
                genres: [28, 18, 12],
                poster: "/51tqzRtKMMZEYUpSYkrUE7v9ehm.jpg",
                backdrop: "/xFYpUmB01nswPgbzi8EOCT1ZYFu.jpg",
                originalLanguage: "en",
                popularity: 3389.624,
                hasVideo: false,
                voteCount: 763,
                isAdult: false,
              )
            ],
          );
        },
      );
    });

    test('load Popular Movies returns an error on failure', () async {
      when(() => mockApiService
              .getMovies('https://api.themoviedb.org/3/movie/popular'))
          .thenAnswer((_) async => Left('Error 404'));

      final result = await movieRemoteRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular);

      expect(
        result,
        isA<Left<String, List<MovieEntity>>>(),
      );
      expect(
        result.fold(
          (error) => error,
          (_) => '',
        ),
        'Error 404',
      );
    });
    test('load movies returns an empty list of movies on success', () async {
      final List<MovieEntity> movieData = [];
      when(() => mockApiService
              .getMovies('https://api.themoviedb.org/3/movie/popular'))
          .thenAnswer((_) async => Right(movieData));
      final result = await movieRemoteRepository.loadMovies(
          movieEndpoint: MovieEndpoint.popular);
      expect(result, isA<Right<String, List<MovieEntity>>>());
      result.fold((error) {
        fail('Expected success, but got error: $error');
      }, (movies) {
        expect(
          movies,
          [],
        );
      });
    });
  });
}
