import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/domain/use_case/implementation/genre_use_case.dart';
import '../../../lib/src/domain/use_case/genre_use_case_i.dart';
import '../../../lib/src/data/datasource/remote/api_service.dart';
import '../../../lib/src/data/repository/genre_remote_repository.dart';
import '../../../lib/src/domain/entity/genre_entity.dart';
import '../../../lib/src/domain/repository/genre_repository_i.dart';

import '../../../lib/src/presentation/bloc/genre_bloc.dart';

class MockGenreRepository extends Mock implements IGenreRepository {}

class MockListUseCase extends Mock implements GenreUseCaseI {}

void main() async {
  group('bloc testing', () {
    late MockGenreRepository mockService = MockGenreRepository();
    late GenreBloc _blocGenreList;
    setUp(() {
      _blocGenreList = GenreBloc(
          genreUseCase: GenreUseCase(
              genreRepository:
                  GenreRemoteRepository(apiService: ApiService())));
    });
    test('fetchGenres adds genres to stream on success', () async {
      _blocGenreList.fetchGenres();
      _blocGenreList.allGenres.listen(expectAsync1((value) {
        expect(
          value,
          isInstanceOf<List<GenreEntity>>(),
        );
      }));
    });

    test('fetchGenres adds empty list', () async {
      when(() => mockService.loadGenres()).thenAnswer(
        (_) async => Right<String, List<GenreEntity>>([]),
      );
      final result = await mockService.loadGenres().fold(
            (error) => error,
            (genres) => genres,
          );
      expect(
        result,
        [],
      );
    });
    test('fetchGenres adds error', () async {
      when(() => mockService.loadGenres()).thenAnswer(
        (_) async => Left<String, List<GenreEntity>>('Error 404'),
      );
      final result = await mockService.loadGenres().fold(
            (error) => error,
            (genres) => genres,
          );
      expect(
        result,
        'Error 404',
      );
    });
    tearDown(() {
      _blocGenreList.dispose();
    });
  });
  group('BlocGenreList usecase', () {
    late GenreBloc bloc;
    late MockListUseCase mockListUseCase;

    setUp(() {
      mockListUseCase = MockListUseCase();
      bloc = GenreBloc(genreUseCase: mockListUseCase);
    });

    test('fetchGenres adds genres to stream on success', () {
      when(() => mockListUseCase.execute()).thenAnswer(
        (_) async => Right<String, List<GenreEntity>>([
          GenreEntity(
            id: 1,
            name: 'Action',
          )
        ]),
      );

      bloc.fetchGenres();

      expectLater(
        bloc.allGenres,
        emits(isInstanceOf<List<GenreEntity>>()),
      );
    });

    test('fetchGenres adds error to stream on failure', () {
      when(() => mockListUseCase.execute()).thenAnswer(
        (_) async => Left<String, List<GenreEntity>>('Error 404'),
      );
      bloc.fetchGenres();
      expectLater(
        bloc.allGenres,
        emitsError('Error 404'),
      );
    });
    tearDown(() {
      bloc.dispose();
    });
  });
}
