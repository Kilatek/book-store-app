import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class CreateAuthor implements UseCase<Author, Author> {
  final AuthorRepository repository;

  CreateAuthor(this.repository);

  @override
  Future<Either<Failure, Author>?> call(Author params) async {
    return await repository.createAuthor(params);
  }
}
