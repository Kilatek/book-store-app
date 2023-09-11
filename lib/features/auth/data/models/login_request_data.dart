import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request_data.freezed.dart';
part 'login_request_data.g.dart';

@freezed
class LoginRequesData with _$LoginRequesData {
  const factory LoginRequesData({
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'password') String? password,
  }) = _LoginRequesData;

  factory LoginRequesData.fromJson(Map<String, dynamic> json) =>
      _$LoginRequesDataFromJson(json);
}
