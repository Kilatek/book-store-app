import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_popup_info.freezed.dart';

/// dialog, bottomsheet
@freezed
class AppPopupInfo with _$AppPopupInfo {
  const factory AppPopupInfo.confirmDialog({
    @Default('') String title,
    @Default('') String message,
    Func0<void>? onPressed,
  }) = _ConfirmDialog;
}

class Func0<R> {
  Func0(this.function);
  final R Function() function;

  @override
  int get hashCode => 0;

  R call() {
    return function.call();
  }

  @override
  bool operator ==(dynamic other) {
    return true;
  }
}
