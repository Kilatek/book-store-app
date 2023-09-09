import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'common_state.freezed.dart';

@freezed
class CommonState extends BaseBlocState with _$CommonState {
  const factory CommonState({
    @Default(false) bool isLoading,
    AppExceptionWrapper? appExceptionWrapper,
  }) = _CommonState;
}
