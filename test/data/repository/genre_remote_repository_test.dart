import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/data/model/data_state.dart';
import '../../../lib/src/data/datasource/remote/api_service.dart';
import '../../../lib/src/data/repository/genre_remote_repository.dart';
import '../../../lib/src/domain/entity/genre_entity.dart';

class MockApiService extends Mock implements ApiService {}

void main() {
  group('GenreRemoteRepository', () {
    late GenreRemoteRepository genreRemoteRepository;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      genreRemoteRepository = GenreRemoteRepository(apiService: mockApiService);
    });

    test('loadGenres returns a list of genres on success', () async {
      final List<GenreEntity> genreData = [
        GenreEntity(
          id: 1,
          name: "Action",
        ),
        GenreEntity(
          id: 2,
          name: "Drama",
        ),
      ];
      when(() => mockApiService.getGenres(
          'https://api.themoviedb.org/3/genre/movie/list')).thenAnswer(
        (_) async => DataSuccess(genreData),
      );

      final result = await genreRemoteRepository.loadGenres();

      expect(
        result,
        isA<DataSuccess>(),
      );

      expect(
        result.data,
        [
          GenreEntity(
            id: 1,
            name: 'Action',
          ),
          GenreEntity(
            id: 2,
            name: 'Drama',
          ),
        ],
      );
    });
    test('loadGenres returns an empty list of genres on success', () async {
      final List<GenreEntity> genreData = [];
      when(() => mockApiService
              .getGenres('https://api.themoviedb.org/3/genre/movie/list'))
          .thenAnswer((_) async => DataSuccess(genreData));
      final result = await genreRemoteRepository.loadGenres();

      expect(
        result.data,
        [],
      );
    });

    test('loadGenres returns an error on failure', () async {
      Exception exception = Exception('Error 404');
      when(() => mockApiService
              .getGenres('https://api.themoviedb.org/3/genre/movie/list'))
          .thenAnswer((_) async => DataFailure(exception));

      final result = await genreRemoteRepository.loadGenres();

      expect(
        result,
        isA<DataFailure>,
      );
      expect(
        'Error 404',
        result.error.toString(),
      );
    });
  });
}
