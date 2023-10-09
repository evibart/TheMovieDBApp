import '../../../core/util/movie_enum.dart';

import '../../../core/util/either_response.dart';
import '../../entity/movie_entity.dart';
import '../../repository/movie_repository_i.dart';
import '../movie_use_case_i.dart';

class MovieUseCase implements MovieUseCaseI<List<MovieEntity>> {
  final IMovieRepository movieRepository;

  MovieUseCase({required this.movieRepository});

  @override
  EitherResponse<List<MovieEntity>> execute({required MovieEndpoint movieEndpoint}) {
    return movieRepository.loadMovies(movieEndpoint: movieEndpoint);
  }
}
