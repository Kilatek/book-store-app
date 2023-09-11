import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/data/models/book_request_data.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class DeleteBookUsecase implements UseCase<Unit, DeleteBookParams> {
  final HomeRepository repository;

  DeleteBookUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(DeleteBookParams params) {
    return repository.deleteBook(
      params.id,
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

class DeleteBookParams extends Equatable {
  final String name;
  final String id;
  final String description;
  final String publicationDate;
  final double price;
  final String authorId;

  const DeleteBookParams({
    required this.id,
    required this.name,
    required this.description,
    required this.publicationDate,
    required this.price,
    required this.authorId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        publicationDate,
        price,
        authorId,
      ];
}
