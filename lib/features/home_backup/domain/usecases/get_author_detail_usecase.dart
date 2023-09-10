import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class GetAuthorDetailUsecase implements UseCase<Author, Params> {
  final HomeRepository repository;

  GetAuthorDetailUsecase(this.repository);

  @override
  Future<Either<AppError, Author>> call(Params params) {
    return repository.getAuthorById(
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
