import '../../core/util/either_response.dart';
import '../../core/util/movie_enum.dart';

abstract class MovieUseCaseI<T> {
  EitherResponse<T> execute({required MovieEndpoint movieEndpoint});
}
