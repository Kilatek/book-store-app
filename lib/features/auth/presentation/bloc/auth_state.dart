import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState extends BaseBlocState with _$AuthState {
  const factory AuthState({
    required Result<String> emailAddress,
    required Result<String> password,
    required bool isShowPassword,
    User? user,
    required bool isSubmitting,
  }) = _AuthState;

  factory AuthState.initial() => AuthState(
        isShowPassword: false,
        emailAddress: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        password: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        isSubmitting: false,
      );
}
