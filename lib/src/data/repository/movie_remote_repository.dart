import '../../core/util/movie_enum.dart';
import '../../domain/entity/movie_entity.dart';
import '../../domain/repository/movie_repository_i.dart';
import '../datasource/remote/api_service.dart';
import '../model/data_state.dart';

class MovieRemoteRepository implements IMovieRepository {
  final ApiService apiService;
  static const String baseUrl = 'https://api.themoviedb.org/3/movie/';
  static const String topRated = 'top_rated';
  static const String popular = 'popular';
  static const String nowPlaying = 'now_playing';
  static const String upComing = 'upcoming';

  MovieRemoteRepository({
    required this.apiService,
  });

  Future<DataState<List<MovieEntity>>> loadMovies(
      {required MovieEndpoint movieEndpoint}) {
    switch (movieEndpoint) {
      case MovieEndpoint.popular:
        return apiService.getMovies('$baseUrl$popular');
      case MovieEndpoint.nowPlaying:
        return apiService.getMovies('$baseUrl$nowPlaying');
      case MovieEndpoint.upComing:
        return apiService.getMovies('$baseUrl$upComing');
      case MovieEndpoint.topRated:
        return apiService.getMovies('$baseUrl$topRated');
    }
  }
}
