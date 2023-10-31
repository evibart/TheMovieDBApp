import 'package:movie_db_app/src/domain/entity/movie_entity.dart';

import '../../domain/repository/movie_database_repository_i.dart';
import '../datasource/local/app_database.dart';

class MovieDatabaseRepository implements IMovieDatabaseRepository {
  final AppDataBase appDataBase;

  MovieDatabaseRepository({required this.appDataBase});

  @override
  Future<List<MovieEntity>> getMovies(String category) {
    return appDataBase.movieDao.getMovies(category);
  }

  @override
  Future<void> saveMovie(MovieEntity movie) {
    return appDataBase.movieDao.saveMovie(movie);
  }

  @override
  Future<MovieEntity?> findMovieById(int id) {
    return appDataBase.movieDao.findMovieById(id);
  }
}
