import 'package:book_store/core/base/base_event.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_event.freezed.dart';

@freezed
class CommonEvent extends BaseBlocEvent with _$CommonEvent {
  const factory CommonEvent.loadingVisibity(bool isLoading) = LoadingChanged;

  const factory CommonEvent.exceptionEmitted(
      AppExceptionWrapper appExceptionWrapper) = ExceptionEmitted;
}
