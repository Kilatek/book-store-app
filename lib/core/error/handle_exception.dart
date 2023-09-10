import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/error/error_listener.dart';

class HandleException {
  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    ErrorListener errorListener,
  ) async {
    switch (appExceptionWrapper.appError.appExceptionType) {
      case AppExceptionType.noInternet:
        return errorListener.onNoInternet(appExceptionWrapper);
      case AppExceptionType.uncaugth:
        return errorListener.onUncaugth(appExceptionWrapper);
      case AppExceptionType.dioError:
        return errorListener.onServerError(appExceptionWrapper);
      default:
        return errorListener.onUncaugth(appExceptionWrapper);
    }
  }
}
