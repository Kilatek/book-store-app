import 'package:book_store/core/base/base_event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent extends BaseBlocEvent with _$HomeEvent {
  const factory HomeEvent.initial() = HomeEventInital;
}
