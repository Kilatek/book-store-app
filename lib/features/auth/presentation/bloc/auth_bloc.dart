import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/util/input_converter.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';
import 'package:book_store/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'auth_event.dart';
import 'auth_state.dart';

@Injectable()
class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  AuthBloc(this._loginUsecase, this._inputConverter)
      : super(AuthState.initial()) {
    on<EmailChanged>(onEmailChanged);
    on<PasswordChanged>(onPasswordChanged);
    on<SignInWithEmailAndPasswordPressed>(onSignInWithEmailAndPasswordPressed);
  }

  final LoginUsecase _loginUsecase;
  final InputConverter _inputConverter;

  Future<void> onEmailChanged(
    EmailChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        emailAddress: _inputConverter.email(event.emailStr),
      ),
    );
    print(state.emailAddress);
  }

  Future<void> onPasswordChanged(
    PasswordChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        password: _inputConverter.password(event.passwordStr),
      ),
    );
  }

  Future<void> onSignInWithEmailAndPasswordPressed(
    SignInWithEmailAndPasswordPressed event,
    Emitter<AuthState> emit,
  ) async {
    final isPasswordValid = state.password.isRight();
    final isEmailValid = state.emailAddress.isRight();
    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<User>(
        _loginUsecase.call(
          Params(
            email: state.emailAddress.getOrElse(() => ''),
            password: state.password.getOrElse(() => ''),
          ),
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              user: auth,
            ),
          );
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }
}
