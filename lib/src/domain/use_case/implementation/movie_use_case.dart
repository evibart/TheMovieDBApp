import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';

import '../../../core/util/movie_enum.dart';

import '../../../core/util/either_response.dart';
import '../../entity/movie_entity.dart';
import '../../repository/movie_database_repository_i.dart';
import '../../repository/movie_repository_i.dart';
import '../movie_use_case_i.dart';

class MovieUseCase implements MovieUseCaseI<List<MovieEntity>> {
  final IMovieRepository movieRepository;
  final IMovieDatabaseRepository movieDataBase;
  static const String localDatabaseError =
      'There was an error loading the local data';

  MovieUseCase({
    required this.movieRepository,
    required this.movieDataBase,
  });

  @override
  EitherResponse<List<MovieEntity>> execute(
      {required MovieEndpoint movieEndpoint}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      try {
        final List<MovieEntity> movies =
            await movieDataBase.getMovies(movieEndpoint.title);
        return Right(movies);
      } catch (e) {
        return Left(Exception(localDatabaseError));
      }
    } else {
      final Either<Exception, List<MovieEntity>> movies =
          await movieRepository.loadMovies(movieEndpoint: movieEndpoint);
      await movies.fold((left) {}, (right) async {
        for (MovieEntity movie in right) {
          MovieEntity? DbMovie = await movieDataBase.findMovieById(movie.id);
          if (DbMovie != null) {
            if (!DbMovie.categories.contains(movieEndpoint.title)) {
              DbMovie.categories.add(movieEndpoint.title);
              movieDataBase.saveMovie(DbMovie);
            }
          } else {
            movie.categories.add(movieEndpoint.title);
            movieDataBase.saveMovie(movie);
          }
          ;
        }
      });
      return movies;
    }
  }
}
