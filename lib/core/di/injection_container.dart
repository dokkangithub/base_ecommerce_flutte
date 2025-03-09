import 'package:get_it/get_it.dart';
import '../../data/datasources/laravel/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/auth/login.dart';
import '../../domain/usecases/auth/register.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';

final sl = GetIt.instance;

void setupDependencies() {
  // // External dependencies
  // sl.registerLazySingleton(() => http.Client());
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectionChecker));

  // API Provider
  // sl.registerLazySingleton<LaravelApiProvider>(
  //       () => LaravelApiProviderImpl(client: sl()),
  // );

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(apiProvider: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  // Register other use cases

  // BLoCs
  sl.registerFactory(
        () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      // Inject other use cases
    ),
  );
}