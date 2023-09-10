import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class DeleteAuthor implements UseCase<NoParams, String> {
  final AuthorRepository repository;

  DeleteAuthor(this.repository);

  @override
  Future<Either<Failure, NoParams>?> call(String id) async {
    return await repository.deleteAuthor(id);
  }
}
