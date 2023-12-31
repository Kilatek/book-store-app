import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/base/base_event.dart';
import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/util/stream_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

mixin BaseBlocMixin<E extends BaseBlocEvent, S extends BaseBlocState>
    on BaseBlocDelegete<E, S> {
  String get name => runtimeType.toString();
  Future<void> runBlocCatching<T>(
    FutureOr<Either<AppError, T>> action, {
    FutureOr<void> Function(AppError)? doOnError,
    FutureOr<void> Function(T)? doOnSuccess,
    Future<void> Function()? doOnRetry,
    FutureOr<void> Function()? doOnCompleleted,
    bool isHandleLoading = true,
    bool isHandleError = true,
  }) async {
    if (isHandleLoading) {
      showLoading();
    }
    final value = await action;
    await value.fold(
      (appError) async {
        if (isHandleLoading) {
          hideLoading();
        }
        if (isHandleError) {
          addException(
            AppExceptionWrapper(
              appError: appError,
              doOnRetry: doOnRetry,
            ),
          );
        }
        await doOnError?.call(appError);
      },
      (r) async {
        if (isHandleLoading) {
          hideLoading();
        }
        await doOnSuccess?.call(r);
      },
    );
    await doOnCompleleted?.call();
  }

  EventTransformer<Event> throttleTime<Event>({
    Duration duration = const Duration(milliseconds: 500),
    bool trailing = false,
    bool leading = true,
  }) {
    return (events, mapper) => events
        .throttleTime(
          duration,
          trailing: trailing,
          leading: leading,
        )
        .flatMap(mapper);
  }

  EventTransformer<Event> log<Event>() {
    return (events, mapper) =>
        events.log(name, logOnData: true).flatMap(mapper);
  }
}
