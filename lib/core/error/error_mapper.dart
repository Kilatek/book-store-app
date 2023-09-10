import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:dio/dio.dart';

class ErrorMapperFactory {
  static AppError map(Object error) {
    switch (error.runtimeType) {
      case DioException:
        final message = (error as DioException).response?.data['message'];
        return AppError(
          appExceptionType: AppExceptionType.dioError,
          message: message ?? (error).response?.statusMessage,
          error: error,
        );
      case NotInterNetException:
        return AppError(
          appExceptionType: AppExceptionType.noInternet,
          message: 'No Internet Connection',
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
          message: 'Value not Empty',
          error: error,
        );
      case ValidateWronEmailException:
        return AppError(
          appExceptionType: AppExceptionType.validateWrongEmail,
          message: 'Wrong email format',
          error: error,
        );
      case ValidateWronPasswordException:
        return AppError(
          appExceptionType: AppExceptionType.validateWrongPassword,
          message: 'Password must be at least 6 characters',
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
