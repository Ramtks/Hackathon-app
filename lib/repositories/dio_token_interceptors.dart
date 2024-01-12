import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';

import '../datasource/datasource.dart';

///
class TokenInterceptor extends Interceptor {
  ///
  TokenInterceptor(this._cacheHelper);

  final CacheHelper _cacheHelper;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get the token from the shared preferences.
    final accessToken = await _cacheHelper.getTokenFromCache();

    if (accessToken != null) {
      // Add the idToken to the request header.
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    // Continue the request.
    handler.next(options);
  }
}

///
class ApiInterceptor extends Interceptor {
  ///
  ApiInterceptor(this._dio);
  final Dio _dio;
  // final AuthRepository _authRepository;

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode == 401) {
      // final token = await _tryToRefreshToken();
      // if (token == null) {
        return handler
            .reject(DioException(requestOptions: response.requestOptions));
      // }
      // response.requestOptions.headers['Authorization'] = 'Bearer $token';
      // return handler.resolve(await _dio.fetch(response.requestOptions));
    }
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // if (err.response?.statusCode == 401) {
    //   // Try to refresh the token
    //   final token = await _tryToRefreshToken();
    //   // If the token is valid, retry the request
    //   if (token != null) {
    //     err.requestOptions.headers['Authorization'] = 'Bearer $token';
    //     return handler.resolve(await _dio.fetch(err.requestOptions));
    //   }
    // }
    return handler.next(err);
  }

  // Future<String?> _tryToRefreshToken() async {
  //   final response = await _authRepository.refreshToken();
  //   return response.fold(
  //     (l) => l,
  //     (r) => null,
  //   );
  // }
}

/// Used in debug mode to log the request and response to the console
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    log('base url: ${options.baseUrl}');
    log('''---
REQUEST[${options.method}] => PATH: ${options.path}
${options.queryParameters} => Authorization: ${options.headers['Authorization']}
---
''');
    return handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log('''---
RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}
${response.data}
---
''');
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('''---
ERROR[${err.response?.statusCode}] => PATH: ${err.response?.requestOptions.path}
${err.response?.data}
---
''');
    super.onError(err, handler);
  }
}

///
class CustomRetryInterceptor extends RetryInterceptor {
  ///
  CustomRetryInterceptor(Dio dio)
      : super(
          dio: dio,
          retryEvaluator: (error, attempt) {
            if (error.response?.statusCode == status401Unauthorized) {
              return false;
            }
            return true;
          },
        );
}

/// This helper extension used to help us identifying the [SocketException]
extension DioExceptionX on DioException {
  ///
  bool get isSocketException =>
      (type == DioExceptionType.unknown ||
          type == DioExceptionType.connectionError) &&
      error is SocketException;
}
