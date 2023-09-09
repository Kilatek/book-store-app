import 'package:book_store/core/network/base/dio_builder.dart';
import 'package:book_store/core/network/middleware/access_token_interceptor.dart';
import 'package:book_store/core/network/middleware/refresh_token_interceptor.dart';
import 'package:book_store/core/network/base/network_constants.dart';
import 'package:book_store/core/network/refresh_rest_client.dart';
import 'package:book_store/core/network/rest_client.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'di.config.dart';

@module
abstract class ServiceModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get flutterSecureStorage => const FlutterSecureStorage(
        aOptions: AndroidOptions(
          encryptedSharedPreferences: true,
        ),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );

  @singleton
  RestClient restClient(
    AccessTokenInterceptor accessTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
  ) =>
      RestClient(
        DioBuilder.createDio(
          options: BaseOptions(baseUrl: NetworkConstants.appApiBaseUrl),
          interceptors: [
            accessTokenInterceptor,
            refreshTokenInterceptor,
          ],
        ),
      );

  @singleton
  RefreshRestClient refreshRestClient(
    AccessTokenInterceptor accessTokenInterceptor,
  ) =>
      RefreshRestClient(
        DioBuilder.createDio(
          options: BaseOptions(baseUrl: NetworkConstants.appApiBaseUrl),
          interceptors: [
            accessTokenInterceptor,
          ],
        ),
      );

  @lazySingleton
  FirebaseDatabase get firebaseStorage => FirebaseDatabase.instance;

  @injectable
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance();
}

final GetIt getIt = GetIt.instance;
@injectableInit
void configureInjection() => getIt.init();
