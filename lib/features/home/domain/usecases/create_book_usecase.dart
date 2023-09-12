import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home/data/models/book_request_data.dart';
import 'package:book_store/features/home/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class CreateBookUsecase implements UseCase<Unit, CreateBookParams> {
  final HomeRepository repository;

  CreateBookUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(CreateBookParams params) {
    return repository.createBook(
      BookRequestData(
        name: params.name,
        description: params.description,
        publicationDate: params.publicationDate,
        price: params.price,
        authorId: params.authorId,
      ),
    );
  }
}

class CreateBookParams extends Equatable {
  final String name;
  final String description;
  final String publicationDate;
  final double price;
  final String authorId;

  const CreateBookParams({
    required this.name,
    required this.description,
    required this.publicationDate,
    required this.price,
    required this.authorId,
  });

  @override
  List<Object?> get props => [
        name,
        description,
        publicationDate,
        price,
        authorId,
      ];
}
