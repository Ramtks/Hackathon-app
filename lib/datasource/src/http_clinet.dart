import 'package:dio/dio.dart';

///
abstract interface class HttpClient {
  ///
  Future<Response<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    bool isBytes,
  });

  ///
  Future<Response<dynamic>> post(String url, {Map<String, dynamic>? data});

  ///
  Future<Response<dynamic>> put(String url, {Map<String, dynamic>? data});

  ///
  Future<Response<dynamic>> delete(String url);

  ///
  Future<Response<dynamic>> multipartRequest(
    String url, {
    required FormData file,
    Map<String, dynamic>? queryParameters,
  });
}
