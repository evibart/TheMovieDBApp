import '../../core/util/movie_enum.dart';
import '../../data/model/data_state.dart';

abstract class MovieUseCaseI<T> {
  Future<DataState<T>> execute({required MovieEndpoint movieEndpoint});
}
