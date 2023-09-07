abstract class IRepository<T> {
  Future<T> loadData();
}
