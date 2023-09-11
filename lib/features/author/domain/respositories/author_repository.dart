import 'package:book_store/core/error/app_error.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/author_get_all_model.dart';
import '../entities/author.dart';

abstract class AuthorRepository {
  Future<Either<AppError, Author>>? createAuthor(Author author);
  Future<Either<AppError, List<GetAuthorsModel>>>? getAuthors();
  Future<Either<AppError, Author>>? findAuthor(String id);
  Future<Either<AppError, GetAuthorsModel>>? updateAuthor(
      GetAuthorsModel author);
  Future<Either<AppError, NoParams>>? deleteAuthor(String id);
}
