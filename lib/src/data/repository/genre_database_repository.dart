import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entity/genre_entity.dart';

import '../../domain/repository/genre_database_repository_i.dart';
import '../datasource/local/dao/genre_dao.dart';
import '../datasource/local/database_provider.dart';

part 'genre_database_repository.g.dart';

class GenreDatabaseRepository implements IGenreDatabaseRepository {
  final GenreDao genreDao;

  GenreDatabaseRepository({required this.genreDao});

  @override
  Future<List<GenreEntity>> getGenres() {
    return genreDao.getGenres();
  }

  @override
  Future<void> saveGenre(GenreEntity genre) {
    return genreDao.saveGenre(genre);
  }

  @override
  Future<GenreEntity?> findGenreById(int id) {
    return genreDao.findGenreById(id);
  }
}

@riverpod
GenreDatabaseRepository genreDatabaseRepository(
        GenreDatabaseRepositoryRef ref) =>
    GenreDatabaseRepository(
      genreDao: ref.watch(databaseProvider.notifier).database!.genreDao,
    );
