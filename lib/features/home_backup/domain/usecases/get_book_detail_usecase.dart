import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class GetBookDetailUsecase implements UseCase<Book, Params> {
  final HomeRepository repository;

  GetBookDetailUsecase(this.repository);

  @override
  Future<Either<AppError, Book>> call(Params params) {
    return repository.getBookById(
      params.id,
    );
  }
}

class Params extends Equatable {
  final String id;

  const Params({required this.id});

  @override
  List<Object?> get props => [id];
}
