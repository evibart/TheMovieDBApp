import '../entity/genre_entity.dart';

abstract class IGenreDatabaseRepository {
  Future<List<GenreEntity>> getGenres();

  Future<void> saveGenre(GenreEntity genre);

  Future<GenreEntity?> findGenreById(int id);
}
