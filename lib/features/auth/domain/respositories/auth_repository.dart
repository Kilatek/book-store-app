import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Result<User>> login({
    required String email,
    required String password,
  });

  Future<UnitResult> clearCurrentUserData();
  Future<Result<bool>> isLoginUser();
}
