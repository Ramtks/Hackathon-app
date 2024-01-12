import 'package:hackathon_app/datasource/src/cache.dart';
import 'package:hive/hive.dart';

/// Implementation of the [Cache] abstract class using Hive as the storage solution.
class HiveCache<T> implements Cache<T> {
  ///
  HiveCache(this._box);
  final Box<dynamic> _box;

  /// Saves the provided [value] in the cache with the specified [key].
  @override
  Future<void> save(String key, T value) async {
    await _box.put(key, value);
  }


  /// Retrieves the value associated with the provided [key] from the cache.
  @override
  Future<T?> get(String key) async {
    return _box.get(key) as T?;
  }


  /// Checks whether the cache contains a value associated with the provided [key].
  @override
  Future<bool> contains(String key) async {
    return _box.containsKey(key);
  }


  /// Removes the value associated with the provided [key] from the cache.
  @override
  Future<void> remove(String key) async {
    await _box.delete(key);
  }


  /// Clears all the entries in the cache.
  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
