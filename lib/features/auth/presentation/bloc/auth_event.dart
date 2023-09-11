import 'package:book_store/core/base/base_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.freezed.dart';

@freezed
class AuthEvent extends BaseBlocEvent with _$AuthEvent {
  const factory AuthEvent.emailChanged(String emailStr) = EmailChanged;
  const factory AuthEvent.initial() = AuthEventInitial;
  const factory AuthEvent.passwordChanged(String passwordStr) = PasswordChanged;
  const factory AuthEvent.signInWithEmailAndPasswordPressed() =
      SignInWithEmailAndPasswordPressed;
}
