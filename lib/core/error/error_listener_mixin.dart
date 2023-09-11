import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/base/common/common_event.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/error/error_listener.dart';
import 'package:flutter/material.dart';

mixin ErrorListenerMixin<T extends StatefulWidget, B extends BaseBloc>
    on BasePageStateDelegete<T, B> implements ErrorListener {
  @override
  void onNoInternet(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    navigator.showErrorSnackBar(message: appExceptionWrapper.appError.message);
  }

  @override
  void onUncaugth(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    logE(appExceptionWrapper.toString());
  }

  @override
  void onServerError(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    navigator.showErrorSnackBar(message: appExceptionWrapper.appError.message);
  }

  @override
  void onRefreshTokenFail(
    AppExceptionWrapper appExceptionWrapper,
  ) {
    commonBloc.add(const CommonEvent.foreLogout());
  }
}
