import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/base/base_page.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/error/error_listener.dart';
import 'package:book_store/core/util/view_utils.dart';
import 'package:flutter/material.dart';

mixin ErrorListenerMixin<T extends StatefulWidget, B extends BaseBloc>
    on BasePageStateDelegete<T, B> implements ErrorListener {
  @override
  void onNoInternet(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    ViewUtils.showAppSnackBar(
      context,
      appExceptionWrapper.appError.message,
      backgroundColor: Colors.red,
    );
  }

  @override
  void onUncaugth(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    logE(appExceptionWrapper.toString());
  }

  @override
  void onServerError(
    AppExceptionWrapper appExceptionWrapper,
    BuildContext context,
  ) {
    ViewUtils.showAppSnackBar(
      context,
      appExceptionWrapper.appError.message,
      backgroundColor: Colors.red,
    );
  }
}
