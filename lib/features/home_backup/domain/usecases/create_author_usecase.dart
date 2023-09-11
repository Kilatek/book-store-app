import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/data/models/author_request_data.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class CreateAuthorUsecase implements UseCase<Unit, CreateAuthorParams> {
  final HomeRepository repository;

  CreateAuthorUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(CreateAuthorParams params) {
    return repository.createAuthor(
      AuthorRequestData(
        firstName: params.firstName,
        lastName: params.lastName,
        birthDate: params.birthDate,
        nationality: params.nationality,
      ),
    );
  }
}

class CreateAuthorParams extends Equatable {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String nationality;

  const CreateAuthorParams({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.nationality,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        birthDate,
        nationality,
      ];
}
