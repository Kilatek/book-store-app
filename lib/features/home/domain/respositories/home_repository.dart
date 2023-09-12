import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home/domain/entities/author.dart';
import 'package:book_store/features/home/domain/entities/book.dart';
import 'package:book_store/features/home/data/models/author_request_data.dart';
import 'package:book_store/features/home/data/models/book_request_data.dart';

abstract class HomeRepository {
  Future<Result<List<Book>>> getBooks();

  Future<Result<List<Author>>> getAuthors();

  Future<Result<Book>> getBookById(
    String id,
  );

  Future<Result<Author>> getAuthorById(
    String id,
  );

  Future<UnitResult> createBook(
    BookRequestData data,
  );

  Future<UnitResult> createAuthor(
    AuthorRequestData data,
  );

  Future<UnitResult> updateBook(
    String id,
    BookRequestData data,
  );

  Future<UnitResult> updateAuthor(
    String id,
    AuthorRequestData data,
  );

  Future<UnitResult> deleteBook(
    String id,
    BookRequestData data,
  );

  Future<UnitResult> deleteAuthor(
    String id,
    AuthorRequestData data,
  );

  Stream<Result<String>> getActionStream(String ref);
}
