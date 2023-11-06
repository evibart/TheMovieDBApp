import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../data/model/data_state.dart';
import '../../entity/genre_entity.dart';
import '../../repository/genre_database_repository_i.dart';
import '../../repository/genre_repository_i.dart';
import '../genre_use_case_i.dart';

class GenreUseCase implements GenreUseCaseI<List<GenreEntity>> {
  final IGenreRepository genreRepository;
  IGenreDatabaseRepository genreDatabaseRepository;
  static const String localDatabaseError =
      'There was an error loading the local data';

  GenreUseCase({
    required this.genreRepository,
    required this.genreDatabaseRepository,
  });

  @override
  Future<DataState<List<GenreEntity>>> execute() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      final List<GenreEntity> genres =
          await genreDatabaseRepository.getGenres();
      return DataSuccess(genres);
    } else {
      final DataState<List<GenreEntity>> genres =
          await genreRepository.loadGenres();

      for (GenreEntity genre in genres.data!) {
        GenreEntity? DbGenre =
            await genreDatabaseRepository.findGenreById(genre.id);
        if (DbGenre == null) {
          genreDatabaseRepository.saveGenre(genre);
        }
      }

      return genres;
    }
  }
}
