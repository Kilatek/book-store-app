import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/exceptions.dart';

class ErrorMapperFactory {
  static AppError map(Object error) {
    switch (error.runtimeType) {
      case NotInterNetException:
        return AppError(
          appExceptionType: AppExceptionType.noInternet,
          message: AppExceptionType.noInternet.toString(),
          error: error,
        );
      case ServerException:
        return AppError(
          appExceptionType: AppExceptionType.serverError,
          message: error.toString(),
          error: error,
        );
      case RefreshTokenException:
        return AppError(
          appExceptionType: AppExceptionType.refreshTokenFail,
          message: error.toString(),
          error: error,
        );
      case CacheException:
        return AppError(
          appExceptionType: AppExceptionType.cacheError,
          message: error.toString(),
          error: error,
        );
      case ValidateEmptyException:
        return AppError(
          appExceptionType: AppExceptionType.validateEmpty,
          message: error.toString(),
          error: error,
        );
      case ValidateWronEmailException:
        return AppError(
          appExceptionType: AppExceptionType.validateWrongEmail,
          message: error.toString(),
          error: error,
        );
      case ValidateWronPasswordException:
        return AppError(
          appExceptionType: AppExceptionType.validateWrongPassword,
          message: error.toString(),
          error: error,
        );
      default:
        return AppError(
          appExceptionType: AppExceptionType.uncaugth,
          message: error.toString(),
          error: error,
        );
    }
  }
}
