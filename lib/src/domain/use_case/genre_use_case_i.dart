import '../../data/model/data_state.dart';

abstract class GenreUseCaseI<T> {
  Future<DataState<T>> execute();
}
