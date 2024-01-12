/// Abstract class representing a cache for storing and retrieving data.
abstract class Cache<T> {
  /// Saves the provided [value] in the cache with the specified [key].
  Future<void> save(String key, T value);

  /// Retrieves the value associated with the provided [key] from the cache.
  Future<T?> get(String key);

  /// Checks whether the cache contains a value associated with the provided [key].
  Future<bool> contains(String key);

  /// Removes the value associated with the provided [key] from the cache.
  Future<void> remove(String key);

  /// Clears all the entries in the cache.
  Future<void> clear();
}
