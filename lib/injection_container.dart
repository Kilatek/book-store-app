import 'package:book_store/features/author/data/datasources/author_remote_data_source.dart';
import 'package:book_store/features/author/data/repositories/author_repository_impl.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:book_store/features/author/domain/usecases/create_author.dart';
import 'package:book_store/features/author/domain/usecases/delete_author.dart';
import 'package:book_store/features/author/domain/usecases/find_author.dart';
import 'package:book_store/features/author/domain/usecases/get_authors.dart';
import 'package:book_store/features/author/domain/usecases/update_author.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/middleware/network_info.dart';
import 'core/util/input_converter.dart';
import 'package:get_it/get_it.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton(() => CreateAuthor(sl()));
  sl.registerLazySingleton(() => DeleteAuthor(sl()));
  sl.registerLazySingleton(() => FindAuthor(sl()));
  sl.registerLazySingleton(() => GetAuthors(sl()));
  sl.registerLazySingleton(() => UpdateAuthor(sl()));

  // Repository
  sl.registerLazySingleton<AuthorRepository>(() => AuthorRepositoryImpl(
        networkInfo: sl(),
        createAuthorRemoteDataSource: sl(),
        getAllAuthorsRemoteDataSource: sl(),
        deleteAuthorsRemoteDataSource: sl(),
        updateAuthorsRemoteDataSource: sl(),
      ));
  // Data sources
  sl.registerLazySingleton<CreateAuthorRemoteDataSource>(
      () => AuthorRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GetAllAuthorsRemoteDataSource>(
      () => AuthorRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<DeleteAuthorsRemoteDataSource>(
      () => AuthorRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UpdateAuthorsRemoteDataSource>(
      () => AuthorRemoteDataSourceImpl(client: sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
