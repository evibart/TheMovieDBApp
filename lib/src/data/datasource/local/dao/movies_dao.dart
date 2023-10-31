import 'package:floor/floor.dart';

import '../../../../domain/entity/movie_entity.dart';

@dao
abstract class MovieDao {
  @Query("SELECT * FROM MovieEntity where categories LIKE '%' || :category || '%'")
  Future<List<MovieEntity>> getMovies(String category);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveMovie(
     MovieEntity movie
  );

  @Query('SELECT * FROM MovieEntity WHERE id = :id')
  Future<MovieEntity?> findMovieById(int id);
}
