import 'package:freezed_annotation/freezed_annotation.dart';

part 'author.freezed.dart';

@freezed
class Author with _$Author {
  const factory Author({
    @Default(Author.defaultId) String id,
    @Default(Author.defaultFirstName) String firstName,
    @Default(Author.defaultLastName) String lastName,
    @Default(Author.defaultBirthDate) String birthDate,
    @Default(Author.defaultNationality) String nationality,
    @Default(Author.defaultCreatedAt) String createdAt,
    @Default(Author.defaultUpdatedAt) String updatedAt,
    @Default(Author.defaultImage) String image,
  }) = _Author;

  static const defaultId = '';
  static const defaultBirthDate = '';
  static const defaultFirstName = '';
  static const defaultLastName = '';
  static const defaultNationality = '';
  static const defaultCreatedAt = '';
  static const defaultUpdatedAt = '';
  static const defaultImage = '';
}
