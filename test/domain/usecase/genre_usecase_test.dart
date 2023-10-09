import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/domain/use_case/implementation/genre_use_case.dart';
import '../../../lib/src/domain/entity/genre_entity.dart';
import '../../../lib/src/domain/repository/genre_repository_i.dart';

class MockGenreRepository extends Mock implements IGenreRepository {}

void main() {
  group('GenreListUseCase', () {
    late GenreUseCase genreListUseCase;
    late MockGenreRepository mockGenreRepository;

    setUp(() {
      mockGenreRepository = MockGenreRepository();
      genreListUseCase = GenreUseCase(genreRepository: mockGenreRepository);
    });

    test('execute returns a list of genres on success', () async {
      when(() => mockGenreRepository.loadGenres()).thenAnswer(
        (_) async => Right<String, List<GenreEntity>>([
          GenreEntity(
            id: 1,
            name: 'Action',
          )
        ]),
      );

      final result = await genreListUseCase.execute();

      expect(
        result,
        isA<Right<String, List<GenreEntity>>>(),
      );
      result.fold(
        (error) {
          fail('Expected success, but got error: $error');
        },
        (genres) {
          expect(
            genres,
            [
              GenreEntity(
                id: 1,
                name: 'Action',
              )
            ],
          );
        },
      );
    });
    test('execute returns an empty list of genres on success', () async {
      when(() => mockGenreRepository.loadGenres()).thenAnswer(
        (_) async => Right<String, List<GenreEntity>>([]),
      );

      final result = await genreListUseCase.execute();

      expect(
        result,
        isA<Right<String, List<GenreEntity>>>(),
      );
      result.fold(
        (error) {
          fail('Expected success, but got error: $error');
        },
        (genres) {
          expect(
            genres,
            [],
          );
        },
      );
    });
    test('execute returns an error on failure', () async {
      when(() => mockGenreRepository.loadGenres()).thenAnswer(
        (_) async => Left<String, List<GenreEntity>>('Error 404'),
      );

      final result = await genreListUseCase.execute();

      expect(
        result,
        isA<Left<String, List<GenreEntity>>>(),
      );
      expect(
        result.fold(
          (error) => error,
          (_) => '',
        ),
        'Error 404',
      );
    });
  });
}
