import 'package:book_store/core/base/base_event.dart';
import 'package:book_store/core/base/base_mixin.dart';
import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/core/base/common/common_bloc.dart';
import 'package:book_store/core/base/common/common_event.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/util/log_mixin.dart';
import 'package:book_store/navigation/app_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E extends BaseBlocEvent, S extends BaseBlocState>
    extends BaseBlocDelegete<E, S> with BaseBlocMixin, LogMixin {
  BaseBloc(S initialState) : super(initialState);
}

abstract class BaseBlocDelegete<E extends BaseBlocEvent,
    S extends BaseBlocState> extends Bloc<E, S> {
  BaseBlocDelegete(S initialState) : super(initialState);
  late final AppNavigator navigator;
  late final CommonBloc commonBloc;

  void showLoading() {
    commonBloc.add(const CommonEvent.loadingVisibity(true));
  }

  void hideLoading() {
    commonBloc.add(const CommonEvent.loadingVisibity(false));
  }

  void addException(AppExceptionWrapper appExceptionWrapper) {
    commonBloc.add(CommonEvent.exceptionEmitted(appExceptionWrapper));
  }
}
