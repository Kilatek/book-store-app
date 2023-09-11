import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/features/auth/domain/usecases/clear_current_user_usecase.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'common_event.dart';
import 'common_state.dart';

@Injectable()
class CommonBloc extends BaseBloc<CommonEvent, CommonState> {
  CommonBloc(this._clearCurrentUserDataUseCase) : super(const CommonState()) {
    on<LoadingChanged>(onLoadingChanged);
    on<ExceptionEmitted>(onExceptionEmitted);
    on<ForceLogoutButtonPressed>(
      onForceLogoutButtonPressed,
      transformer: log(),
    );
  }

  final ClearCurrentUserUsecase _clearCurrentUserDataUseCase;

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

  Future<void> onForceLogoutButtonPressed(
    ForceLogoutButtonPressed event,
    Emitter<CommonState> emit,
  ) async {
    await _clearCurrentUserDataUseCase.call(unit);
    await navigator.replace(const AuthRoute());
  }
}
