import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_request_data.freezed.dart';
part 'author_request_data.g.dart';

@freezed
class AuthorRequestData with _$AuthorRequestData {
  const factory AuthorRequestData({
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'birthDate') String? birthDate,
    @JsonKey(name: 'nationality') String? nationality,
  }) = _AuthorRequestData;

  factory AuthorRequestData.fromJson(Map<String, dynamic> json) =>
      _$AuthorRequestDataFromJson(json);
}
