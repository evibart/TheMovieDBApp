import '../../domain/entity/genre_entity.dart';
import '../../domain/repository/genre_repository_i.dart';
import '../datasource/remote/api_service.dart';
import '../model/data_state.dart';

class GenreRemoteRepository implements IGenreRepository {
  final ApiService apiService;
  static const String baseUrl = 'https://api.themoviedb.org/3/genre/movie/list';

  GenreRemoteRepository({required this.apiService});

  @override
  Future<DataState<List<GenreEntity>>> loadGenres() async {
    return apiService.getGenres(baseUrl);
  }
}
