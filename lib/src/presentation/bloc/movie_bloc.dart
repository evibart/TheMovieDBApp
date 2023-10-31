import 'dart:async';

import 'package:either_dart/either.dart';

import '../../core/util/movie_enum.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/use_case/implementation/movie_use_case.dart';

import 'bloc_i.dart';

class MovieBloc implements IBloc {
  MovieBloc({
    required this.moviesUseCase,
  });

  final MovieUseCase moviesUseCase;

  final StreamController<List<MovieEntity>> _movieList =
      StreamController<List<MovieEntity>>();

  Stream<List<MovieEntity>> get allMovies => _movieList.stream;

  void fetchMovies(MovieEndpoint movieEndpoint) async =>
      await moviesUseCase.execute(movieEndpoint: movieEndpoint).fold(
            (error) => _movieList.sink.addError(error.toString()),
            (movieList) => _movieList.sink.add(movieList),
          );

  @override
  void dispose() {
    _movieList.close();
  }

  @override
  void initialize() {}
}
