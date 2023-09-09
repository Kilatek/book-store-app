import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:flutter/material.dart';

abstract class ErrorListener {
  void onNoInternet(
      AppExceptionWrapper appExceptionWrapper, BuildContext context);
  void onUncaugth(
      AppExceptionWrapper appExceptionWrapper, BuildContext context);
}
