import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

class FindAuthor implements UseCase<Author, Author> {
  final AuthorRepository repository;

  FindAuthor(this.repository);

  @override
  Future<Either<AppError, Author>> call(Author params) async {
    return await repository.createAuthor(params)!;
  }
}
