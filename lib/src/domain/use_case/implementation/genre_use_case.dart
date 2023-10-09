import '../../../core/util/either_response.dart';
import '../../entity/genre_entity.dart';
import '../../repository/genre_repository_i.dart';
import '../genre_use_case_i.dart';

class GenreUseCase implements GenreUseCaseI<List<GenreEntity>> {
  final IGenreRepository genreRepository;

  GenreUseCase({required this.genreRepository});

  @override
  EitherResponse<List<GenreEntity>> execute() {
    return genreRepository.loadGenres();
  }
}
