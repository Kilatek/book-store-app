import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/data/models/author_request_data.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class UpdateAuthorUsecase implements UseCase<Unit, UpdateAuthorParams> {
  final HomeRepository repository;

  UpdateAuthorUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(UpdateAuthorParams params) {
    return repository.updateAuthor(
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

class UpdateAuthorParams extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String nationality;

  const UpdateAuthorParams({
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
