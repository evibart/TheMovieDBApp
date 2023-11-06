import '../../core/util/movie_enum.dart';
import '../../data/model/data_state.dart';
import '../entity/movie_entity.dart';

abstract class IMovieRepository<T> {
  Future<DataState<List<MovieEntity>>> loadMovies(
      {required MovieEndpoint movieEndpoint});
}
