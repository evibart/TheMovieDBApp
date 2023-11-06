import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../lib/src/data/model/data_state.dart';
import '../../../lib/src/domain/use_case/implementation/genre_use_case.dart';
import '../../../lib/src/domain/entity/genre_entity.dart';

import '../../../lib/src/presentation/bloc/genre_bloc.dart';

class MockUseCase extends Mock implements GenreUseCase {}

void main() async {
  group('bloc testing', () {
    late MockUseCase mockService = MockUseCase();
    late GenreBloc _blocGenreList;
    setUp(() {
      _blocGenreList = GenreBloc(genreUseCase: mockService);
    });

    test('fetchGenres adds genres to stream on success', () async {
      _blocGenreList.fetchGenres();
      _blocGenreList.allGenres.listen(expectAsync1((value) {
        expect(
          value.actualData,
          isInstanceOf<List<GenreEntity>>(),
        );
      }));
    });

    test('fetchGenres adds empty list', () async {
      when(() => mockService.execute()).thenAnswer(
        (_) async => DataSuccess([]),
      );
      final result = await mockService.execute();
      expect(
        result.data,
        [],
      );
    });
    test('fetchGenres adds error', () async {
      when(() => mockService.execute()).thenAnswer(
        (_) async => DataFailure(Exception('Error 404')),
      );
      final result = await mockService.execute();
      expect(
        result.error.toString(),
        'Error 404',
      );
    });
    tearDown(() {
      _blocGenreList.dispose();
    });
  });
  group('BlocGenreList usecase', () {
    late GenreBloc bloc;
    late MockUseCase mockListUseCase;

    setUp(() {
      mockListUseCase = MockUseCase();
      bloc = GenreBloc(genreUseCase: mockListUseCase);
    });

    test('fetchGenres adds genres to stream on success', () {
      when(() => mockListUseCase.execute()).thenAnswer(
        (_) async => DataSuccess([
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
      when(() => mockListUseCase.execute()).thenAnswer((_) async => DataFailure(
            (Exception('Error 404')),
          ));
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
