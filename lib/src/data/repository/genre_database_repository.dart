import '../../domain/entity/genre_entity.dart';

import '../../domain/repository/genre_database_repository_i.dart';
import '../datasource/local/app_database.dart';

class GenreDatabaseRepository implements IGenreDatabaseRepository {
  final AppDataBase appDataBase;

  GenreDatabaseRepository({required this.appDataBase});

  @override
  Future<List<GenreEntity>> getGenres() {
    return appDataBase.genreDao.getGenres();
  }

  @override
  Future<void> saveGenre(GenreEntity genre) {
    return appDataBase.genreDao.saveGenre(genre);
  }

  @override
  Future<GenreEntity?> findGenreById(int id) {
    return appDataBase.genreDao.findGenreById(id);
  }
}
