import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/error_mapper.dart';
import 'package:book_store/core/preference/app_preferences.dart';
import 'package:book_store/features/home/domain/entities/author.dart';
import 'package:book_store/features/home/domain/entities/book.dart';
import 'package:book_store/features/home/data/datasources/home_remote_data_source.dart';
import 'package:book_store/features/home/data/models/author_data_mapper.dart';
import 'package:book_store/features/home/data/models/author_request_data.dart';
import 'package:book_store/features/home/data/models/book_data_mapper.dart';
import 'package:book_store/features/home/data/models/book_request_data.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/middleware/network_info.dart';

import '../../domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';

typedef TaskExcute<T> = Future<T> Function();

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final AppPreferences appPreferences;
  final NetworkInfo networkInfo;
  final BookDataMapper bookDataMapper;
  final AuthorDataMapper authorDataMapper;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.bookDataMapper,
    required this.appPreferences,
    required this.authorDataMapper,
  });

  Future<Result<T>> handleCommon<T>(TaskExcute<T> task) async {
    try {
      if (await networkInfo.isConnected) {
        return right(await task());
      } else {
        throw NotInterNetException();
      }
    } catch (error) {
      return left(ErrorMapperFactory.map(error));
    }
  }

  @override
  Future<UnitResult> createAuthor(AuthorRequestData data) {
    return handleCommon<Unit>(
      () async {
        await remoteDataSource.createAuthor(data);
        return unit;
      },
    );
  }

  @override
  Future<UnitResult> createBook(BookRequestData data) {
    return handleCommon<Unit>(
      () async {
        await remoteDataSource.createBook(data);
        return unit;
      },
    );
  }

  @override
  Future<UnitResult> deleteAuthor(String id, AuthorRequestData data) {
    return handleCommon<Unit>(
      () async {
        await remoteDataSource.deleteAuthor(id, data);
        return unit;
      },
    );
  }

  @override
  Future<UnitResult> deleteBook(String id, BookRequestData data) {
    return handleCommon<Unit>(
      () async {
        await remoteDataSource.deleteBook(id, data);
        return unit;
      },
    );
  }

  @override
  Future<Result<Author>> getAuthorById(String id) {
    return handleCommon<Author>(
      () async {
        final data = await remoteDataSource.getAuthorById(id);
        return authorDataMapper.mapToEntity(data);
      },
    );
  }

  @override
  Future<Result<List<Author>>> getAuthors() {
    return handleCommon<List<Author>>(
      () async {
        final data = await remoteDataSource.getAuthors();
        return authorDataMapper.mapToListEntity(data);
      },
    );
  }

  @override
  Future<Result<Book>> getBookById(String id) {
    return handleCommon<Book>(
      () async {
        final data = await remoteDataSource.getBookById(id);
        return bookDataMapper.mapToEntity(data);
      },
    );
  }

  @override
  Future<Result<List<Book>>> getBooks() {
    return handleCommon<List<Book>>(
      () async {
        final data = await remoteDataSource.getBooks();
        return bookDataMapper.mapToListEntity(data);
      },
    );
  }

  @override
  Future<UnitResult> updateAuthor(String id, AuthorRequestData data) {
    return handleCommon<Unit>(
      () async {
        await remoteDataSource.updateAuthor(id, data);
        return unit;
      },
    );
  }

  @override
  Future<UnitResult> updateBook(String id, BookRequestData data) {
    return handleCommon<Unit>(
      () async {
        await remoteDataSource.updateBook(id, data);
        return unit;
      },
    );
  }

  @override
  Stream<Result<String>> getActionStream(String ref) {
    return remoteDataSource.getActionStream(ref).map((event) {
      return right<AppError, String>(event);
    }).onErrorReturnWith((error, stackTrace) {
      return left<AppError, String>(ErrorMapperFactory.map(error));
    });
  }
}
