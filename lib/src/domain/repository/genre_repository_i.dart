import '../../data/model/data_state.dart';
import '../entity/genre_entity.dart';

abstract class IGenreRepository {
  Future<DataState<List<GenreEntity>>> loadGenres();
}
