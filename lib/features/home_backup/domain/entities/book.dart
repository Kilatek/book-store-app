import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

@freezed
class Book with _$Book {
  const factory Book({
    @Default(Book.defaultId) String id,
    @Default(Book.defaultAuthor) Author author,
    @Default(Book.defaultName) String name,
    @Default(Book.defaultDescription) String description,
    @Default(Book.defaultPublicationDate) String publicationDate,
    @Default(Book.defaultPrice) double price,
    @Default(Book.defaultCreatedAt) String createdAt,
    @Default(Book.defaultUpdatedAt) String updatedAt,
  }) = _Book;

  static const defaultId = '';
  static const defaultAuthor = Author();
  static const defaultName = '';
  static const defaultDescription = '';
  static const defaultPublicationDate = '';
  static const defaultPrice = 0.0;
  static const defaultCreatedAt = '';
  static const defaultUpdatedAt = '';
}
