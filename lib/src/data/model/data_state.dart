abstract class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({
    this.data,
    this.error,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(Exception error) : super(error: error);
}
