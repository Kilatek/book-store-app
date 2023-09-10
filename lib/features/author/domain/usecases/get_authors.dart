import 'package:book_store/features/author/domain/respositories/author_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/author_get_all_model.dart';

class GetAuthors implements UseCase<List<GetAuthorsModel>, NoParams> {
  final AuthorRepository repository;

  GetAuthors(this.repository);

  @override
  Future<Either<Failure, List<GetAuthorsModel>>?> call(
      NoParams noParams) async {
    return await repository.getAuthors();
  }
}
