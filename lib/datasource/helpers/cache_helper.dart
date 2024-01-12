import 'package:hackathon_app/datasource/src/cache.dart';

/// Class for some methods that helps up
/// getting and setting the [token] and [refreshToken] and {idToken}
class CacheHelper {
  /// Constructor that must have the cache
  CacheHelper(this._cache);

  static const String _tokenCacheKey = 'token';
  static const String _refreshTokenCacheKey = 'refreshToken';
  static const String _idTokenCacheKey = 'idToken';

  final Cache<dynamic> _cache;

  /// Get the Refresh Token From the Cache
  Future<void> saveTokenToCache(String token) async {
    await _cache.save(_tokenCacheKey, token);
    return;
  }

  /// Get the Refresh Token From the Cache
  Future<String?> getTokenFromCache() async {
    return await _cache.get(_tokenCacheKey) as String?;
  }

  /// Get the Refresh Token From the Cache
  Future<void> saveRefreshTokenToCache(String refreshToken) async {
    await _cache.save(_refreshTokenCacheKey, refreshToken);
    return;
  }

  /// Get the Id Token From the Cache
  Future<void> saveIdTokenToCache(String idToken) async {
    await _cache.save(_idTokenCacheKey, idToken);
    return;
  }

  /// Get the Refresh Token From the Cache
  Future<String?> getRefreshTokenFromCache() async {
    return await _cache.get(_refreshTokenCacheKey) as String?;
  }

  /// Get the Id Token From the Cache
  Future<String?> getIdTokenFromCache() async {
    return await _cache.get(_idTokenCacheKey) as String?;
  }

  /// Clear the Access Token and Refresh Token
  Future<void> clearAccessTokenAndRefreshToken() async {
    await _cache.remove(_tokenCacheKey);
    await _cache.remove(_refreshTokenCacheKey);
  }
}
