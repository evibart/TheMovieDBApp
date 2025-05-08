import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/data/model/data_state.dart';
import '../../../lib/src/domain/repository/genre_database_repository_i.dart';
import '../../../lib/src/domain/use_case/implementation/genre_use_case.dart';
import '../../../lib/src/domain/entity/genre_entity.dart';
import '../../../lib/src/domain/repository/genre_repository_i.dart';

class MockGenreRepository extends Mock implements IGenreRepository {}

class MockGenreDataBase extends Mock implements IGenreDatabaseRepository {}

void main() {
  group('GenreListUseCase', () {
    late GenreUseCase genreListUseCase;
    late MockGenreRepository mockGenreRepository;
    late MockGenreDataBase mockGenreDataBase;
    setUp(() {
      mockGenreRepository = MockGenreRepository();
      mockGenreDataBase = MockGenreDataBase();
      genreListUseCase = GenreUseCase(
        genreRepository: mockGenreRepository,
        genreDatabaseRepository: mockGenreDataBase,
      );
    });

    test('execute returns a list of genres on success', () async {
      when(() => mockGenreRepository.loadGenres()).thenAnswer(
        (_) async => DataSuccess<List<GenreEntity>>([
          GenreEntity(
            id: 1,
            name: 'Action',
          )
        ]),
      );

      final result = await genreListUseCase.execute();

      expect(
        result,
        isA<DataSuccess>,
      );

      expect(
        result.data,
        [
          GenreEntity(
            id: 1,
            name: 'Action',
          )
        ],
      );
    });
    test('execute returns an empty list of genres on success', () async {
      when(() => mockGenreRepository.loadGenres()).thenAnswer(
        (_) async => DataSuccess<List<GenreEntity>>([]),
      );

      final result = await genreListUseCase.execute();

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
      when(() => mockGenreRepository.loadGenres()).thenAnswer(
        (_) async => DataFailure(Exception('Error 404')),
      );

      final result = await genreListUseCase.execute();

      expect(
        result,
        isA<DataFailure>,
      );
      expect(
        result.error.toString(),
        'Error 404',
      );
    });
  });
}
