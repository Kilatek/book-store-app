import 'package:book_store/core/base/base_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_event.freezed.dart';

@freezed
class AppEvent extends BaseBlocEvent with _$AppEvent {
  const factory AppEvent.initial() = AppEventInitial;
}
