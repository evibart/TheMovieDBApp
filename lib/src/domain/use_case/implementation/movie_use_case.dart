import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../data/model/data_state.dart';

import '../../../core/util/movie_enum.dart';

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
  Future<DataState<List<MovieEntity>>> execute(
      {required MovieEndpoint movieEndpoint}) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      final List<MovieEntity> movies =
          await movieDataBase.getMovies(movieEndpoint.title);
      return DataSuccess(movies);
    } else {
      final DataState<List<MovieEntity>> movies =
          await movieRepository.loadMovies(movieEndpoint: movieEndpoint);
      for (MovieEntity movie in movies.data!) {
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
      return movies;
    }
  }
}
