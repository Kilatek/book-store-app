import 'package:book_store/features/auth/data/models/auth_response_data.dart';
import 'package:book_store/features/auth/data/models/login_request_data.dart';
import 'package:book_store/features/home_backup/data/models/author_request_data.dart';
import 'package:book_store/features/home_backup/data/models/author_response_data.dart';
import 'package:book_store/features/home_backup/data/models/book_request_data.dart';
import 'package:book_store/features/home_backup/data/models/book_response_data.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST('/login')
  Future<AuthResponseData> login(
    @Body() LoginRequesData loginRequesData,
  );

  @GET('/api/v1/books')
  Future<List<BookResponseData>> getBooks();

  @GET('/api/v1/authors')
  Future<List<AuthorResponseData>> getAuthors();

  @GET('/api/v1/books/{id}')
  Future<BookResponseData> getBookById(
    @Query("id") String id,
  );

  @GET('/api/v1/authors/{id}')
  Future<AuthorResponseData> getAuthorById(
    @Query("id") String id,
  );

  @POST('/api/v1/books')
  Future<BookResponseData> createBook(
    @Body() BookRequestData data,
  );

  @POST('/api/v1/authors')
  Future<AuthorResponseData> createAuthor(
    @Body() AuthorRequestData data,
  );

  @PUT('/api/v1/books/{id}')
  Future<BookResponseData> updateBook(
    @Query("id") String id,
    @Body() BookRequestData data,
  );

  @PUT('/api/v1/authors/{id}')
  Future<AuthorResponseData> updateAuthor(
    @Query("id") String id,
    @Body() AuthorRequestData data,
  );

  @DELETE('/api/v1/books/{id}')
  Future<BookResponseData> deleteBook(
    @Query("id") String id,
    @Body() BookRequestData data,
  );

  @DELETE('/api/v1/authors/{id}')
  Future<AuthorResponseData> deleteAuthor(
    @Query("id") String id,
    @Body() AuthorRequestData data,
  );
}
