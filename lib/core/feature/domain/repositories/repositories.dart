import '../../../../export.dart';

abstract class Repository {
  Future<Either<Failure, Map<String, dynamic>?>> get(String endPoint,
      {Map? data, String? cacheName});
  Future<Either<Failure, Map<String, dynamic>?>> post(
      String endPoint, dynamic data);
  Future<Either<Failure, Map<String, dynamic>?>> update(
      String endPoint, dynamic data);

  Future<Either<Failure, Map<String, dynamic>?>> delete(
      String endPoint, dynamic data);

  dynamic readFromLocalDB(String key);
  Future<void> writeToLocalDB(String key, Map<String, dynamic> value);
}
