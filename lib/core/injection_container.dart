import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:tasker/core/feature/data/repositories/repository_imp.dart';
import 'package:tasker/core/feature/domain/repositories/repositories.dart';
import 'package:tasker/core/network/network.dart';
import 'package:tasker/export.dart';

import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc

  // Usecases

  // Repository
  sl.registerLazySingleton<Repository>(
      () => RepoImp(remoteDataSource: sl(), localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(network: sl(), networkInfo: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Network>(() => Network(dio: sl(), box: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 1000),
        receiveTimeout: const Duration(seconds: 1000),
        // By default, Dio treats any HTTP status code from 200 to 299 as a successful response. If you need a different range or specific conditions, you can override it using validateStatus.
        validateStatus: (status) {
          // Treat status codes less than 500 as successful
          // return status != null && status < 500;
          // it gives "This exception was thrown because the response has a status code of 401 and RequestOptions.validateStatus was configured to throw for this status code.\nThe status code of 401 has the following meaning: \"Client error - the…
          return status != null;
        },
      )));
  sl<Dio>().interceptors.addAll(
    [
      RequestsInspectorInterceptor(),
    ],
  );
}
