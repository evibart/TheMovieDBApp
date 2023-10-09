import '../../core/util/either_response.dart';
import '../entity/genre_entity.dart';

abstract class IGenreRepository {
  EitherResponse<List<GenreEntity>> loadGenres();
}
