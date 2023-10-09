import '../../core/util/either_response.dart';

abstract class GenreUseCaseI<T> {
  EitherResponse<T> execute();
}
