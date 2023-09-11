import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home/domain/entities/book.dart';
import 'package:book_store/features/home/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class GetBooksUsecase implements UseCase<List<Book>, Unit> {
  final HomeRepository repository;

  GetBooksUsecase(this.repository);

  @override
  Future<Either<AppError, List<Book>>> call(Unit params) {
    return repository.getBooks();
  }
}
