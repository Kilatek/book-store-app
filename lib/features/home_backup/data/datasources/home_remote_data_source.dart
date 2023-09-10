import 'package:book_store/core/network/rest_client.dart';
import 'package:book_store/features/home_backup/data/models/author_request_data.dart';
import 'package:book_store/features/home_backup/data/models/author_response_data.dart';
import 'package:book_store/features/home_backup/data/models/book_request_data.dart';
import 'package:book_store/features/home_backup/data/models/book_response_data.dart';
import 'package:injectable/injectable.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookResponseData>> getBooks();

  Future<List<AuthorResponseData>> getAuthors();

  Future<BookResponseData> getBookById(
    String id,
  );

  Future<AuthorResponseData> getAuthorById(
    String id,
  );

  Future<BookResponseData> createBook(
    BookRequestData data,
  );

  Future<AuthorResponseData> createAuthor(
    AuthorRequestData data,
  );

  Future<BookResponseData> updateBook(
    String id,
    BookRequestData data,
  );

  Future<AuthorResponseData> updateAuthor(
    String id,
    AuthorRequestData data,
  );

  Future<BookResponseData> deleteBook(
    String id,
    BookRequestData data,
  );

  Future<AuthorResponseData> deleteAuthor(
    String id,
    AuthorRequestData data,
  );
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final RestClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthorResponseData> createAuthor(
    AuthorRequestData data,
  ) =>
      client.createAuthor(data);

  @override
  Future<BookResponseData> createBook(
    BookRequestData data,
  ) =>
      client.createBook(data);

  @override
  Future<AuthorResponseData> deleteAuthor(
    String id,
    AuthorRequestData data,
  ) =>
      client.deleteAuthor(id, data);

  @override
  Future<BookResponseData> deleteBook(
    String id,
    BookRequestData data,
  ) =>
      client.deleteBook(id, data);

  @override
  Future<AuthorResponseData> getAuthorById(
    String id,
  ) =>
      client.getAuthorById(id);

  @override
  Future<List<AuthorResponseData>> getAuthors() => client.getAuthors();

  @override
  Future<BookResponseData> getBookById(
    String id,
  ) =>
      client.getBookById(id);

  @override
  Future<List<BookResponseData>> getBooks() => client.getBooks();

  @override
  Future<AuthorResponseData> updateAuthor(
    String id,
    AuthorRequestData data,
  ) =>
      client.updateAuthor(id, data);

  @override
  Future<BookResponseData> updateBook(
    String id,
    BookRequestData data,
  ) =>
      client.updateBook(id, data);
}
