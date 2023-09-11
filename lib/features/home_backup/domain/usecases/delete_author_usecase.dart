import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/data/models/author_request_data.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class DeleteAuthorUsecase implements UseCase<Unit, DeleteAuthorParams> {
  final HomeRepository repository;

  DeleteAuthorUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(DeleteAuthorParams params) {
    return repository.deleteAuthor(
      params.id,
      AuthorRequestData(
        firstName: params.firstName,
        lastName: params.lastName,
        birthDate: params.birthDate,
        nationality: params.nationality,
      ),
    );
  }
}

class DeleteAuthorParams extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String nationality;

  const DeleteAuthorParams({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.nationality,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        birthDate,
        nationality,
      ];
}
