import 'package:book_store/features/home/data/models/author_response_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_response_data.freezed.dart';
part 'book_response_data.g.dart';

@freezed
class BookResponseData with _$BookResponseData {
  const factory BookResponseData({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'author') AuthorResponseData? author,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'publicationDate') String? publicationDate,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'updatedAt') String? updatedAt,
  }) = _BookResponseData;

  factory BookResponseData.fromJson(Map<String, dynamic> json) =>
      _$BookResponseDataFromJson(json);
}
