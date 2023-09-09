import 'package:book_store/core/base/base_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState extends BaseBlocState with _$AppState {
  const factory AppState() = _AuthState;
  factory AppState.initial() => const AppState();
}
