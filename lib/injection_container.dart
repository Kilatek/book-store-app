import 'package:book_store/features/author/data/datasources/author_remote_data_source.dart';
import 'package:book_store/features/author/data/repositories/author_repository_impl.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:book_store/features/author/domain/usecases/create_author.dart';
import 'package:book_store/features/author/domain/usecases/delete_author.dart';
import 'package:book_store/features/author/domain/usecases/find_author.dart';
import 'package:book_store/features/author/domain/usecases/get_authors.dart';
import 'package:book_store/features/author/domain/usecases/update_author.dart';
import 'package:book_store/features/author/presentation/bloc/author_bloc.dart';

import 'core/network/network_info.dart';
import 'features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/util/input_converter.dart';
import 'features/number_trivia/data/datasources/number_trivia_local_data_soucre.dart';
import 'features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'features/number_trivia/domain/respositories/number_trivia_repository.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';

// service locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Features - NumberTrivia
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));
  // Data sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: sl()));

  //! Features - NumberTrivia
  sl.registerFactory(() => AuthorBloc(
        createAuthor: sl(),
        deleteAuthor: sl(),
        findAuthor: sl(),
        getAuthors: sl(),
        updateAuthor: sl(),
      ));

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
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
