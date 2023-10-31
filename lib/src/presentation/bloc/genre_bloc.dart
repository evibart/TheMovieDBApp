import 'dart:async';

import 'package:either_dart/either.dart';

import '../../domain/entity/genre_entity.dart';
import '../../domain/use_case/genre_use_case_i.dart';
import 'bloc_i.dart';

class GenreBloc implements IBloc {
  final GenreUseCaseI genreUseCase;
  final StreamController<List<GenreEntity>> _genreList =
      StreamController<List<GenreEntity>>();

  Stream<List<GenreEntity>> get allGenres => _genreList.stream;

  GenreBloc({required this.genreUseCase});

  void fetchGenres() async {
    await genreUseCase.execute().fold(
          (error) => _genreList.sink.addError(error),
          (movieList) => _genreList.sink.add(movieList),
        );
  }

  @override
  void dispose() {
    _genreList.close();
  }

  @override
  void initialize() {}
}
