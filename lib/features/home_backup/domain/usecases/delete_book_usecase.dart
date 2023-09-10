import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/data/models/book_request_data.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class UpdateBookUsecase implements UseCase<Unit, Params> {
  final HomeRepository repository;

  UpdateBookUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(Params params) {
    return repository.deleteBook(
      params.id,
      BookRequestData(
        firstName: params.firstName,
        lastName: params.lastName,
        birthDate: params.birthDate,
        price: params.price,
        authorId: params.authorId,
      ),
    );
  }
}

class Params extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final double price;
  final String authorId;

  const Params({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.price,
    required this.authorId,
  });

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        birthDate,
        price,
        authorId,
      ];
}
