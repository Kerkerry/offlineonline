// Generalize interface for database repository implementation
abstract class InterfaceRepository<T> {
  // Get all data from DB
  Future<T?> getAll();
  // Insert data to database
  Future<void> insertItem({required T object});
  // Is data available
  Future<bool> isDataAvailable();
}
