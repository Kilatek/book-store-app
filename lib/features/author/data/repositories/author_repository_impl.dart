import 'package:book_store/core/usecases/usecase.dart';
import 'package:book_store/features/author/data/models/author_create_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/author_remote_data_source.dart';
import '../../../../core/error/failures.dart';

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
  Future<Either<Failure, Author>> createAuthor(Author author) async {
    return await _createAuthor(() {
      return createAuthorRemoteDataSource.createAuthor(author)!;
    });
  }

  Future<Either<Failure, Author>> _createAuthor(
      _AuthorCreatedModel _authorCreatedModel) async {
    if (await networkInfo.isConnected) {
      try {
        final authorCreate = await _authorCreatedModel();
        return Right(authorCreate);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>>? deleteAuthor(String id) async {
    return await _deleteAuthors(() {
      return deleteAuthorsRemoteDataSource.deleteAuthors(id)!;
    });
  }

  Future<Either<Failure, NoParams>> _deleteAuthors(
      _DeleteAuthorsModel _deleteAuthorsModel) async {
    if (await networkInfo.isConnected) {
      try {
        final deleteAuthors = await _deleteAuthorsModel();
        return Right(deleteAuthors);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Author>>? findAuthor(String id) {
    // TODO: implement findAuthor
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<GetAuthorsModel>>>? getAuthors() async {
    return await _getAuthors(() {
      return getAllAuthorsRemoteDataSource.getAuthors()!;
    });
  }

  Future<Either<Failure, List<GetAuthorsModel>>> _getAuthors(
      _GetAuthorsModel _getAuthorsModel) async {
    if (await networkInfo.isConnected) {
      try {
        final getAuthors = await _getAuthorsModel();
        return Right(getAuthors);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetAuthorsModel>>? updateAuthor(
      GetAuthorsModel author) async {
    return await _updateAuthors(() {
      return updateAuthorsRemoteDataSource.updateAuthors(author)!;
    });
  }

  Future<Either<Failure, GetAuthorsModel>> _updateAuthors(
      _UpdateAuthorsModel _updateAuthorsModel) async {
    if (await networkInfo.isConnected) {
      try {
        final updateAuthors = await _updateAuthorsModel();
        return Right(updateAuthors);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
