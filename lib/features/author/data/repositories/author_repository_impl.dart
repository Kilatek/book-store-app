import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/error_mapper.dart';
import 'package:book_store/core/network/middleware/network_info.dart';
import 'package:book_store/core/usecases/usecase.dart';
import 'package:book_store/features/author/data/models/author_create_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../datasources/author_remote_data_source.dart';

import 'package:dartz/dartz.dart';

import '../models/author_get_all_model.dart';

typedef Future<AuthorCreatedModel> _AuthorCreatedModel();
typedef Future<List<GetAuthorsModel>> _GetAuthorsModel();
typedef Future<NoParams> _DeleteAuthorsModel();
typedef Future<GetAuthorsModel> _UpdateAuthorsModel();

class AuthorRepositoryImpl implements AuthorRepository {
  final CreateAuthorRemoteDataSource createAuthorRemoteDataSource;
  final GetAllAuthorsRemoteDataSource getAllAuthorsRemoteDataSource;
  final DeleteAuthorsRemoteDataSource deleteAuthorsRemoteDataSource;
  final UpdateAuthorsRemoteDataSource updateAuthorsRemoteDataSource;

  final NetworkInfo networkInfo;

  AuthorRepositoryImpl({
    required this.createAuthorRemoteDataSource,
    required this.getAllAuthorsRemoteDataSource,
    required this.deleteAuthorsRemoteDataSource,
    required this.updateAuthorsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<AppError, Author>> createAuthor(Author author) async {
    return await _createAuthor(() {
      return createAuthorRemoteDataSource.createAuthor(author)!;
    });
  }

  Future<Either<AppError, Author>> _createAuthor(
      _AuthorCreatedModel _authorCreatedModel) async {
    if (await networkInfo.isConnected) {
      try {
        final authorCreate = await _authorCreatedModel();
        return Right(authorCreate);
      } catch (error) {
        return left(ErrorMapperFactory.map(error));
      }
    } else {
      throw NotInterNetException();
    }
  }

  @override
  Future<Either<AppError, NoParams>>? deleteAuthor(String id) async {
    return await _deleteAuthors(() {
      return deleteAuthorsRemoteDataSource.deleteAuthors(id)!;
    });
  }

  Future<Either<AppError, NoParams>> _deleteAuthors(
      _DeleteAuthorsModel _deleteAuthorsModel) async {
    if (await networkInfo.isConnected) {
      try {
        final deleteAuthors = await _deleteAuthorsModel();
        return Right(deleteAuthors);
      } catch (error) {
        return left(ErrorMapperFactory.map(error));
      }
    } else {
      throw NotInterNetException();
    }
  }

  @override
  Future<Either<AppError, Author>>? findAuthor(String id) {
    // TODO: implement findAuthor
    throw UnimplementedError();
  }

  @override
  Future<Either<AppError, List<GetAuthorsModel>>>? getAuthors() async {
    return await _getAuthors(() {
      return getAllAuthorsRemoteDataSource.getAuthors()!;
    });
  }

  Future<Either<AppError, List<GetAuthorsModel>>> _getAuthors(
      _GetAuthorsModel _getAuthorsModel) async {
    if (await networkInfo.isConnected) {
      try {
        final getAuthors = await _getAuthorsModel();
        return Right(getAuthors);
      } catch (error) {
        return left(ErrorMapperFactory.map(error));
      }
    } else {
      throw NotInterNetException();
    }
  }

  @override
  Future<Either<AppError, GetAuthorsModel>>? updateAuthor(
      GetAuthorsModel author) async {
    return await _updateAuthors(() {
      return updateAuthorsRemoteDataSource.updateAuthors(author)!;
    });
  }

  Future<Either<AppError, GetAuthorsModel>> _updateAuthors(
      _UpdateAuthorsModel _updateAuthorsModel) async {
    if (await networkInfo.isConnected) {
      try {
        final updateAuthors = await _updateAuthorsModel();
        return Right(updateAuthors);
      } catch (error) {
        return left(ErrorMapperFactory.map(error));
      }
    } else {
      throw NotInterNetException();
    }
  }
}
