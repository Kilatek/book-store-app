import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState extends BaseBlocState with _$AuthState {
  const factory AuthState({
    required String emailAddress,
    required String password,
    User? user,
    required bool isSubmitting,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(
        emailAddress: '',
        password: '',
        isSubmitting: false,
      );
}
