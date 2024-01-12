import 'package:dio/dio.dart';
import 'package:hackathon_app/datasource/src/http_clinet.dart';

///
class CustomHttpClient implements HttpClient {
  ///
  CustomHttpClient(this.dio, this.baseUrl);

  ///
  final Dio dio;

  ///
  final String baseUrl;

  @override
  Future<Response<dynamic>> get(
    String url, {
    bool isBytes = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.get(url,
        queryParameters: queryParameters,
        options: Options(responseType: isBytes ? ResponseType.bytes : null));
  }

  @override
  Future<Response<dynamic>> post(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return dio.post(url, data: data);
  }

  @override
  Future<Response<dynamic>> put(
    String url, {
    Map<String, dynamic>? data,
  }) async {
    return dio.put(url, data: data);
  }

  @override
  Future<Response<dynamic>> delete(String url) async {
    return dio.delete(url);
  }

  @override
  Future<Response<dynamic>> multipartRequest(
    String url, {
    required FormData file,
    Map<String, dynamic>? queryParameters,
  }) async {
    return dio.post(
      url,
      queryParameters: queryParameters,
      data: file,
      options: Options(
        method: "POST",
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': 'text/plain',
        },
      ),
    );
  }
}
