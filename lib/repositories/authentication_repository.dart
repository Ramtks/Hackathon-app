import 'package:dartz/dartz.dart';
import 'package:hackathon_app/repositories/utils/repositories_error.dart';
import '../datasource/datasource.dart';

abstract class AuthRepository {
  Future<Either<bool, RepositoriesError>> checkIfSignedIn();
  Future<Either<void, RepositoriesError>> signIn(String email, String password);
  Future<Either<void, RepositoriesError>> signUp(
      String email, String name, String password);
  Future<Either<void, RepositoriesError>> logOut();
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
      if (response.statusCode == 200) {
        await _cacheHelper.saveTokenToCache(response.data['token']['access']);
        return const Left(null);
      }
      return Right(RepositoriesError(
          exception: Exception(), stackTrace: StackTrace.empty));
    } on Exception catch (e, stackTrace) {
      return Right(RepositoriesError(exception: e, stackTrace: stackTrace));
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
        await _cacheHelper.saveTokenToCache(response.data['token']['access']);
        return const Left(null);
      }
      return Right(RepositoriesError(
          exception: Exception(), stackTrace: StackTrace.empty));
    } on Exception catch (e, stackTrace) {
      return Right(RepositoriesError(exception: e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<bool, RepositoriesError>> checkIfSignedIn() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      final accessToken = await _cacheHelper.getTokenFromCache();
      print(accessToken);
      if (accessToken == null) {
        return const Left(false);
      }
      return const Left(true);
    } on Exception catch (e, stackTrace) {
      return Right(RepositoriesError(exception: e, stackTrace: stackTrace));
    }
  }

  @override
  Future<Either<void, RepositoriesError>> logOut() async {
    try {
      await _cacheHelper.clearAccessTokenAndRefreshToken();
      return const Left(null);
    } on Exception catch (e, stackTrace) {
      return Right(RepositoriesError(exception: e, stackTrace: stackTrace));
    }
  }
}
