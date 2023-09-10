import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class GetAuthorsUsecase implements UseCase<List<Author>, Unit> {
  final HomeRepository repository;

  GetAuthorsUsecase(this.repository);

  @override
  Future<Either<AppError, List<Author>>> call(Unit params) {
    return repository.getAuthors();
  }
}
