import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'common_event.dart';
import 'common_state.dart';

@LazySingleton()
class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc() : super(const CommonState()) {
    on<LoadingChanged>(onLoadingChanged);
    on<ExceptionEmitted>(onExceptionEmitted);
  }

  Future<void> onLoadingChanged(
    LoadingChanged event,
    Emitter<CommonState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: event.isLoading,
      ),
    );
  }

  Future<void> onExceptionEmitted(
    ExceptionEmitted event,
    Emitter<CommonState> emit,
  ) async {
    emit(
      state.copyWith(
        appExceptionWrapper: event.appExceptionWrapper,
      ),
    );
  }
}
