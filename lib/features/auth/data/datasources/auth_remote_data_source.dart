import 'package:book_store/core/network/rest_client.dart';
import 'package:book_store/features/auth/data/models/auth_response_data.dart';
import 'package:book_store/features/auth/data/models/login_request_data.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseData> login({
    required String email,
    required String password,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final RestClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseData> login({
    required String email,
    required String password,
  }) =>
      client.login(
        LoginRequesData(
          username: email,
          password: password,
        ),
      );
}
