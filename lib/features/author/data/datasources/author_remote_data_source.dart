import 'dart:convert';

import 'package:book_store/core/usecases/usecase.dart';
import 'package:book_store/features/author/data/models/author_create_model.dart';
import 'package:book_store/features/author/data/models/author_get_all_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';

abstract class CreateAuthorRemoteDataSource {
  Future<AuthorCreatedModel>? createAuthor(Author author);
}

abstract class GetAllAuthorsRemoteDataSource {
  Future<List<GetAuthorsModel>>? getAuthors();
}

abstract class DeleteAuthorsRemoteDataSource {
  Future<NoParams>? deleteAuthors(String id);
}

abstract class UpdateAuthorsRemoteDataSource {
  Future<GetAuthorsModel>? updateAuthors(GetAuthorsModel author);
}

class AuthorRemoteDataSourceImpl
    implements
        CreateAuthorRemoteDataSource,
        GetAllAuthorsRemoteDataSource,
        DeleteAuthorsRemoteDataSource,
        UpdateAuthorsRemoteDataSource {
  final Dio client;
  // TODO: need to change to load token from shared
  String fakeToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InVzZXIxIiwiZXhwIjoxNjk0NDg1ODYwfQ.IPjkIxTswDslcIfEvyNyWf6KiSNl8Y3NhRf2gLgjWSM';

  AuthorRemoteDataSourceImpl({required this.client});

  Future<AuthorCreatedModel> _createAuthor(String url, Author author) async {
    final response = await client.post(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': fakeToken,
        },
      ),
      data: jsonEncode(<String, String>{
        "firstName": author.firstName,
        "lastName": author.lastName,
        "birthDate": author.birthDate,
        "Nationality": author.Nationality
      }),
    );
    if (response.statusCode == 200) {
      return AuthorCreatedModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthorCreatedModel>? createAuthor(Author author) =>
      _createAuthor('http://159.223.95.179/api/v1/authors', author);

  Future<List<GetAuthorsModel>> _getAuthors(String url) async {
    final response = await client.get(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': fakeToken,
        },
      ),
    );
    if (response.statusCode == 200) {
      return List<GetAuthorsModel>.from(json
          .decode(response.data)
          .map((model) => GetAuthorsModel.fromJson(model)));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<GetAuthorsModel>>? getAuthors() =>
      _getAuthors('http://159.223.95.179/api/v1/authors');

  Future<NoParams> _deleteAuthors(String url) async {
    final response = await client.delete(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': fakeToken,
        },
      ),
    );
    if (response.statusCode == 200) {
      return NoParams();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NoParams>? deleteAuthors(String id) =>
      _deleteAuthors('http://159.223.95.179/api/v1/authors/$id');

  Future<GetAuthorsModel> _updateAuthors(
      String url, GetAuthorsModel author) async {
    final response = await client.put(
      url,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': fakeToken,
        },
      ),
      data: jsonEncode(<String, String>{
        "firstName": author.firstName!,
        "lastName": author.lastName!,
        "birthDate": author.birthDate!,
        "Nationality": author.nationality!
      }),
    );
    if (response.statusCode == 200) {
      return GetAuthorsModel.fromJson(json.decode(response.data));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GetAuthorsModel>? updateAuthors(GetAuthorsModel author) =>
      _updateAuthors(
          'http://159.223.95.179/api/v1/authors/${author.id}', author);
}
