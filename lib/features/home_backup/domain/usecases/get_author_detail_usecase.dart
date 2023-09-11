import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class GetAuthorDetailUsecase implements UseCase<Author, GetAuthorDetailParams> {
  final HomeRepository repository;

  GetAuthorDetailUsecase(this.repository);

  @override
  Future<Either<AppError, Author>> call(GetAuthorDetailParams params) {
    return repository.getAuthorById(
      params.id,
    );
  }
}

class GetAuthorDetailParams extends Equatable {
  final String id;

  const GetAuthorDetailParams({required this.id});

  @override
  List<Object?> get props => [id];
}
