import 'package:dartz/dartz.dart';
import 'package:hackathon_app/repositories/utils/repositories_error.dart';
import '../datasource/datasource.dart';

abstract class AuthRepository {
  Future<Either<bool, RepositoriesError>> checkIfSignedIn();
  Future<Either<void, RepositoriesError>> signIn(String email, String password);
  Future<Either<void, RepositoriesError>> signUp(
      String email, String name, String password);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._httpClient, this._cacheHelper);
  final HttpClient _httpClient;
  final CacheHelper _cacheHelper;
  @override
  Future<Either<void, RepositoriesError>> signIn(
      String email, String password) async {
    try {
      final body = {
        'email': email,
        'password': password,
      };
      final response = await _httpClient.post(
        StaticVariables.signin,
        data: body,
      );
      if (response.statusCode == 201) {
        await _cacheHelper.saveTokenToCache(response.data['token']);
        return const Left(null);
      }
      return Right(RepositoriesError(
          exception: Exception(), stackTrace: StackTrace.empty));
    } on Exception catch (e) {
      return Right(
          RepositoriesError(exception: e, stackTrace: StackTrace.empty));
    }
  }

  @override
  Future<Either<void, RepositoriesError>> signUp(
      String email, String name, String password) async {
    try {
      final body = {
        'contact_name': name,
        'email': email,
        'password1': password,
        'password2': password
      };
      final response = await _httpClient.post(
        StaticVariables.signup,
        data: body,
      );
      if (response.statusCode == 201) {
        await _cacheHelper.saveTokenToCache(response.data['token']);
        return const Left(null);
      }
      return Right(RepositoriesError(
          exception: Exception(), stackTrace: StackTrace.empty));
    } on Exception catch (e) {
      return Right(
          RepositoriesError(exception: e, stackTrace: StackTrace.empty));
    }
  }

  @override
  Future<Either<bool, RepositoriesError>> checkIfSignedIn() async {
    try {
      final accessToken = await _cacheHelper.getTokenFromCache();
      if (accessToken == null) {
        return const Left(false);
      }
      return const Left(true);
    } on Exception catch (e) {
      return Right(
          RepositoriesError(exception: e, stackTrace: StackTrace.empty));
    }
  }
}
