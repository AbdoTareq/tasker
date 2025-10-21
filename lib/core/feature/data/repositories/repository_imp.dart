import 'package:tasker/export.dart';

import '../../domain/repositories/repositories.dart';

class RepoImp implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  RepoImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>?>> get(String endPoint,
      {dynamic data, String? cacheName}) async {
    final res = await remoteDataSource.get(endPoint, data);
    return res.fold(
      (failure) async {
        if (failure is OfflineFailure && cacheName != null) {
          if (await localDataSource.containsKey(cacheName)) {
            final cachedData = await localDataSource.read(cacheName);
            return Right(cachedData);
          }
          return left(const EmptyCacheFailure(message: 'no_data'));
        }
        return left(failure);
      },
      (serverResponse) {
        if (cacheName != null && serverResponse.data != null) {
          localDataSource.write(cacheName, serverResponse.toJson());
        }
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> post(
      String endPoint, dynamic data) async {
    final res = await remoteDataSource.post(endPoint, data);
    return res.fold(
      (failure) {
        return left(failure);
      },
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> update(
      String endPoint, dynamic data) async {
    final res = await remoteDataSource.put(endPoint, data);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  Future<Either<Failure, Map<String, dynamic>?>> delete(
      String endPoint, dynamic data) async {
    final res = await remoteDataSource.delete(endPoint, data);
    return res.fold(
      (failure) => left(failure),
      (serverResponse) {
        return right(serverResponse.data);
      },
    );
  }

  @override
  dynamic readFromLocalDB(String key) => localDataSource.read(key);

  @override
  Future<void> writeToLocalDB(String key, Map<String, dynamic> value) async =>
      await localDataSource.write(key, value);
}
