import 'dart:convert';
import 'dart:io';

import 'package:book_store/core/usecases/usecase.dart';
import 'package:book_store/features/author/data/models/author_create_model.dart';
import 'package:book_store/features/author/data/models/author_get_all_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';

import '../../../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

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
  final http.Client client;
  // TODO: need to change to load token from shared
  String fakeToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InVzZXIxIiwiZXhwIjoxNjk0Mzg0Njk3fQ.nMZKza2VoN3z0AhaGfGq0UprYipK5zV-77vU8RyYiHY';

  AuthorRemoteDataSourceImpl({required this.client});

  Future<AuthorCreatedModel> _createAuthor(String url, Author author) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': fakeToken,
      },
      body: jsonEncode(<String, String>{
        "firstName": author.firstName,
        "lastName": author.lastName,
        "birthDate": author.birthDate,
        "Nationality": author.Nationality
      }),
    );
    if (response.statusCode == 200) {
      return AuthorCreatedModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthorCreatedModel>? createAuthor(Author author) =>
      _createAuthor('http://159.223.95.179/api/v1/authors', author);

  Future<List<GetAuthorsModel>> _getAuthors(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': fakeToken,
      },
    );
    if (response.statusCode == 200) {
      return List<GetAuthorsModel>.from(json
          .decode(response.body)
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
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': fakeToken,
      },
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
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': fakeToken,
      },
      body: jsonEncode(<String, String>{
        "firstName": author.firstName!,
        "lastName": author.lastName!,
        "birthDate": author.birthDate!,
        "Nationality": author.nationality!
      }),
    );
    if (response.statusCode == 200) {
      return GetAuthorsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GetAuthorsModel>? updateAuthors(GetAuthorsModel author) =>
      _updateAuthors(
          'http://159.223.95.179/api/v1/authors/${author.id}', author);
}
