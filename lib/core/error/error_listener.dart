import 'package:book_store/core/error/app_exception_wrapper.dart';

abstract class ErrorListener {
  void onNoInternet(AppExceptionWrapper appExceptionWrapper);
  void onUncaugth(AppExceptionWrapper appExceptionWrapper);

  void onServerError(AppExceptionWrapper appExceptionWrapper);
}
