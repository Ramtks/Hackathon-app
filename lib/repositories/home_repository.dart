import 'package:dartz/dartz.dart';
import 'package:hackathon_app/repositories/models/Party.dart';
import 'package:hackathon_app/repositories/utils/repositories_error.dart';

import '../datasource/datasource.dart';

abstract class HomeRepository {
  Future<Either<List<Party>, RepositoriesError>> getStreamers();
}

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._httpClient, this._cacheHelper);

  final HttpClient _httpClient;
  final CacheHelper _cacheHelper;
  @override
  Future<Either<List<Party>, RepositoriesError>> getStreamers() async {
    try {
      final response = await _httpClient.get(
        StaticVariables.fetchStreamers,
      );
      if (response.statusCode == 201) {
        final result = response.data['streamers'] as Map<String, dynamic>;
        return Left(List.generate(
            result.length, (index) => Party.fromMap(result[index])));
      }
      return Right(RepositoriesError(
          exception: Exception(), stackTrace: StackTrace.empty));
    } on Exception catch (e, stackTrace) {
      return Right(RepositoriesError(exception: e, stackTrace: stackTrace));
    }
  }
}
