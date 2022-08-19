import 'package:waslny_user/features/localization/data/datasources/localization_local_data_source.dart';
import 'package:waslny_user/features/localization/domain/repositories/localization_repository.dart';
import 'package:waslny_user/features/localization/domain/usecases/get_locale_use_case.dart';

import 'core/network/network_info.dart';
import 'features/localization/data/repositories/localization_repository_impl.dart';
import 'features/localization/domain/usecases/set_locale_use_case.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/localization/presentation/cubits/localization_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initLocalization();
}

Future<void> initLocalization() async {
//
//---------------------* Localization *-------------------------------
//! Features - Localization

//! Bloc

  sl.registerFactory(() => LocalizationCubit(
        getLocaleUseCase: sl(),
        setLocaleUseCase: sl(),
      ));

//! Use Cases

  sl.registerLazySingleton(
      () => GetLocaleUseCase(localizationRepository: sl()));
  sl.registerLazySingleton(
      () => SetLocaleUseCase(localizationRepository: sl()));

//! Repository

  sl.registerLazySingleton<LocalizationRepository>(
    () => LocalizationRepositoryImpl(localizationLocalDataSource: sl()),
  );

//! Data Sources

  sl.registerLazySingleton<LocalizationLocalDataSource>(
      () => LocalizationLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

//-----------------------------------------------------------------
//
// //! Features - posts
//
// // Bloc
//
//   sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
//   sl.registerFactory(() => AddDeleteUpdatePostBloc(
//       addPost: sl(), updatePost: sl(), deletePost: sl()));
//
// // Usecases
//
//   sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
//   sl.registerLazySingleton(() => AddPostUsecase(sl()));
//   sl.registerLazySingleton(() => DeletePostUsecase(sl()));
//   sl.registerLazySingleton(() => UpdatePostUsecase(sl()));
//
// // Repository
//
//   sl.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
//       remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
//
// // Datasources
//
//   sl.registerLazySingleton<PostRemoteDataSource>(
//       () => PostRemoteDataSourceImpl(client: sl()));
//   sl.registerLazySingleton<PostLocalDataSource>(
//       () => PostLocalDataSourceImpl(sharedPreferences: sl()));
//
// //! Core
//
//   sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
//
// //! External
//
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => InternetConnectionChecker());
}
