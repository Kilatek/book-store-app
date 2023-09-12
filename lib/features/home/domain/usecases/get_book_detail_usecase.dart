import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home/domain/entities/book.dart';
import 'package:book_store/features/home/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class GetBookDetailUsecase implements UseCase<Book, GetBookDetailParams> {
  final HomeRepository repository;

  GetBookDetailUsecase(this.repository);

  @override
  Future<Either<AppError, Book>> call(GetBookDetailParams params) {
    return repository.getBookById(
      params.id,
    );
  }
}

class GetBookDetailParams extends Equatable {
  final String id;

  const GetBookDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
