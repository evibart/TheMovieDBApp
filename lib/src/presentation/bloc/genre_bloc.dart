import 'dart:async';

import '../../core/util/status.dart';
import '../../data/model/data_state.dart';
import '../../domain/entity/data.dart';
import '../../domain/entity/genre_entity.dart';
import '../../domain/use_case/implementation/genre_use_case.dart';
import 'bloc_i.dart';

class GenreBloc implements IBloc {
  final GenreUseCase genreUseCase;
  final StreamController<Data<List<GenreEntity>>> _genreList =
      StreamController<Data<List<GenreEntity>>>();

  Stream<Data<List<GenreEntity>>> get allGenres => _genreList.stream;

  Data<List<GenreEntity>> get initialData => Data<List<GenreEntity>>(
        state: Status.loading,
      );

  GenreBloc({required this.genreUseCase});

  void fetchGenres() async {
    DataState<List<GenreEntity>> response = await genreUseCase.execute();
    Data<List<GenreEntity>> data = response is DataFailure
        ? Data(
            state: Status.failed,
            error: response.error.toString(),
          )
        : Data(
            state: response.data!.isEmpty ? Status.empty : Status.success,
            actualData: response.data);

    _genreList.sink.add(data);
  }

  @override
  void dispose() {
    _genreList.close();
  }

  @override
  void initialize() {}
}
