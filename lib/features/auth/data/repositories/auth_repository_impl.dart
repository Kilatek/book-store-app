import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/error_mapper.dart';
import 'package:book_store/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:book_store/features/auth/data/models/user_data_mapper.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/middleware/network_info.dart';

import '../../domain/respositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

typedef TaskExcute<T> = Future<T> Function();

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final UserDataMapper userDataMapper;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.userDataMapper,
  });

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) =>
      handleCommon(
        () async {
          final user = await remoteDataSource.login(
            email: email,
            password: password,
          );
          return userDataMapper.mapToEntity(user.data);
        },
      );

  Future<Result<T>> handleCommon<T>(TaskExcute<T> task) async {
    try {
      if (await networkInfo.isConnected) {
        return right(await task());
      } else {
        throw NotInterNetException();
      }
    } catch (error) {
      return left(ErrorMapperFactory.map(error));
    }
  }
}
