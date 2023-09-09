import 'package:book_store/core/error/app_error.dart';

class AppExceptionWrapper {
  AppExceptionWrapper({
    required this.appError,
    this.doOnRetry,
  });

  final AppError appError;

  final Future<void> Function()? doOnRetry;

  @override
  String toString() => appError.toString();
}
