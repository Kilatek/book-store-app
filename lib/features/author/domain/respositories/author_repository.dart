import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/author_get_all_model.dart';
import '../entities/author.dart';

abstract class AuthorRepository {
  Future<Either<Failure, Author>>? createAuthor(Author author);
  Future<Either<Failure, List<GetAuthorsModel>>>? getAuthors();
  Future<Either<Failure, Author>>? findAuthor(String id);
  Future<Either<Failure, GetAuthorsModel>>? updateAuthor(
      GetAuthorsModel author);
  Future<Either<Failure, NoParams>>? deleteAuthor(String id);
}
