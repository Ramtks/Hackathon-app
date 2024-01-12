import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hackathon_app/repositories/authentication_repository.dart';
import 'package:hackathon_app/repositories/dio_token_interceptors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hackathon_app/datasource/datasource.dart';

final getIt = GetIt.instance;
Future<void> setup() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: StaticVariables.host,
      sendTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      validateStatus: (int? status) {
        return true;
      },
    ),
  );
  await Hive.initFlutter();
  final Box<dynamic> box = await Hive.openBox('cache_box');
  getIt
    ..registerSingleton<HttpClient>(CustomHttpClient(dio, StaticVariables.host))
    ..registerSingleton<Cache<dynamic>>(HiveCache(box))
    ..registerSingleton<CacheHelper>(CacheHelper(getIt()))
    ..registerSingleton<LoggingInterceptor>(LoggingInterceptor())
    ..registerSingleton<AuthRepository>(
      AuthRepositoryImpl(getIt(), getIt()),
    )
    ..registerSingleton<ApiInterceptor>(ApiInterceptor(dio))
    ..registerSingleton<TokenInterceptor>(TokenInterceptor(getIt()))
    ..registerSingleton<CustomRetryInterceptor>(CustomRetryInterceptor(dio));
}
