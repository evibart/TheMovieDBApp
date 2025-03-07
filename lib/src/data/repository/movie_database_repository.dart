import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entity/movie_entity.dart';

import '../../domain/repository/movie_database_repository_i.dart';
import '../datasource/local/dao/movies_dao.dart';
import '../datasource/local/database_provider.dart';

part 'movie_database_repository.g.dart';

class MovieDatabaseRepository implements IMovieDatabaseRepository {
  final MovieDao movieDao;

  MovieDatabaseRepository({required this.movieDao});

  @override
  Future<List<MovieEntity>> getMovies(String category) {
    return movieDao.getMovies(category);
  }

  @override
  Future<void> saveMovie(MovieEntity movie) {
    return movieDao.saveMovie(movie);
  }

  @override
  Future<MovieEntity?> findMovieById(int id) {
    return movieDao.findMovieById(id);
  }
}

@riverpod
MovieDatabaseRepository movieDatabaseRepository(
        MovieDatabaseRepositoryRef ref) =>
    MovieDatabaseRepository(
      movieDao: ref.watch(databaseProvider.notifier).database!.movieDao,
    );
