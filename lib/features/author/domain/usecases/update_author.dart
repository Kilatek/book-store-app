import 'package:book_store/features/author/data/models/author_get_all_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class UpdateAuthor implements UseCase<GetAuthorsModel, GetAuthorsModel> {
  final AuthorRepository repository;

  UpdateAuthor(this.repository);

  @override
  Future<Either<Failure, GetAuthorsModel>?> call(GetAuthorsModel params) async {
    return await repository.updateAuthor(params);
  }
}
