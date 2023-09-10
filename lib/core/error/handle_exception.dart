import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/error/error_listener.dart';
import 'package:flutter/material.dart';

class HandleException {
  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
    ErrorListener errorListener,
  ) async {
    switch (appExceptionWrapper.appError.appExceptionType) {
      case AppExceptionType.noInternet:
        return errorListener.onNoInternet(appExceptionWrapper, context);
      case AppExceptionType.uncaugth:
        return errorListener.onUncaugth(appExceptionWrapper, context);
      case AppExceptionType.dioError:
        return errorListener.onServerError(appExceptionWrapper, context);
      default:
        return errorListener.onUncaugth(appExceptionWrapper, context);
    }
  }
}
