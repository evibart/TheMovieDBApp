import '../../core/util/either_response.dart';
import '../../core/util/movie_enum.dart';
import '../entity/movie_entity.dart';

abstract class IMovieRepository<T> {
  EitherResponse<List<MovieEntity>> loadMovies(
      {required MovieEndpoint movieEndpoint});
}
