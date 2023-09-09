import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_data.freezed.dart';
part 'auth_response_data.g.dart';

@freezed
class AuthResponseData with _$AuthResponseData {
  const factory AuthResponseData({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
  }) = _AuthResponseData;

  factory AuthResponseData.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDataFromJson(json);
}
