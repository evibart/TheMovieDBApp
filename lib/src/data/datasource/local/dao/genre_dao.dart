import 'package:floor/floor.dart';

import '../../../../domain/entity/genre_entity.dart';

@dao
abstract class GenreDao {
  @Query('SELECT * From GenreEntity')
  Future<List<GenreEntity>> getGenres();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveGenre(GenreEntity genre);

  @Query('SELECT * FROM GenreEntity WHERE id = :id')
  Future<GenreEntity?> findGenreById(int id);
}
