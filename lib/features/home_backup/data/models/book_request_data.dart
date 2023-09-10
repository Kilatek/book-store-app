import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_request_data.freezed.dart';
part 'book_request_data.g.dart';

@freezed
class BookRequestData with _$BookRequestData {
  const factory BookRequestData({
    @JsonKey(name: 'name') String? firstName,
    @JsonKey(name: 'description') String? lastName,
    @JsonKey(name: 'publicationDate') String? birthDate,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'authorId') String? authorId,
  }) = _BookRequestData;

  factory BookRequestData.fromJson(Map<String, dynamic> json) =>
      _$BookRequestDataFromJson(json);
}
