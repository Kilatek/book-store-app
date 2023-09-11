import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_response_data.freezed.dart';
part 'author_response_data.g.dart';

@freezed
class AuthorResponseData with _$AuthorResponseData {
  const factory AuthorResponseData({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'firstName') String? firstName,
    @JsonKey(name: 'lastName') String? lastName,
    @JsonKey(name: 'birthDate') String? birthDate,
    @JsonKey(name: 'nationality') String? nationality,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
  }) = _AuthorResponseData;

  factory AuthorResponseData.fromJson(Map<String, dynamic> json) =>
      _$AuthorResponseDataFromJson(json);
}
