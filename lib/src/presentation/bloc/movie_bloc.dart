import 'dart:async';

import '../../core/util/movie_enum.dart';
import '../../core/util/status.dart';
import '../../data/model/data_state.dart';
import '../../domain/entity/data.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/use_case/implementation/movie_use_case.dart';

import 'bloc_i.dart';

class MovieBloc implements IBloc {
  MovieBloc({
    required this.moviesUseCase,
  });

  final MovieUseCase moviesUseCase;

  final StreamController<Data<List<MovieEntity>>> _movieList =
      StreamController<Data<List<MovieEntity>>>();

  Data<List<MovieEntity>> get initialData => Data<List<MovieEntity>>(
        state: Status.loading,
      );

  Stream<Data<List<MovieEntity>>> get allMovies => _movieList.stream;

  void fetchMovies(MovieEndpoint movieEndpoint) async {
    DataState<List<MovieEntity>> response =
        await moviesUseCase.execute(movieEndpoint: movieEndpoint);
    Data<List<MovieEntity>> data = response is DataFailure
        ? Data(
            state: Status.failed,
            error: response.error.toString(),
          )
        : Data(
            state: response.data!.isEmpty ? Status.empty : Status.success,
            actualData: response.data);

    _movieList.sink.add(data);
  }

  @override
  void dispose() {
    _movieList.close();
  }

  @override
  void initialize() {}
}
