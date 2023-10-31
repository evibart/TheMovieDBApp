import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';

import '../../../core/util/either_response.dart';
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
  EitherResponse<List<GenreEntity>> execute() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      try {
        List<GenreEntity> genres = await genreDatabaseRepository.getGenres();
        return Right(genres);
      } catch (e) {
        return Left(Exception(localDatabaseError));
      }
    } else {
      final Either<Exception, List<GenreEntity>> genres =
          await genreRepository.loadGenres();
      genres.fold((left) {}, (right) async {
        for (GenreEntity genre in right) {
          GenreEntity? DbGenre =
              await genreDatabaseRepository.findGenreById(genre.id);
          if (DbGenre == null) {
            genreDatabaseRepository.saveGenre(genre);
          }
        }
      });
      return genres;
    }
  }
}
