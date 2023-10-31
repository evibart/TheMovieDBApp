import '../entity/movie_entity.dart';

abstract class IMovieDatabaseRepository {
  Future<List<MovieEntity>> getMovies(String category);

  Future<void> saveMovie(MovieEntity movie);

  Future<MovieEntity?> findMovieById(int id);
}
