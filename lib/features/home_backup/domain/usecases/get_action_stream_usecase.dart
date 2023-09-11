import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/usecases/usecase_stream.dart';
import 'package:book_store/features/home_backup/domain/respositories/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetActionStreamUsecase implements UseCaseStream<String, Params> {
  final HomeRepository repository;

  GetActionStreamUsecase(this.repository);

  @override
  Stream<Either<AppError, String>> call(Params params) {
    return repository.getActionStream(params.ref);
  }
}

class Params extends Equatable {
  final String ref;

  const Params({
    required this.ref,
  });

  @override
  List<Object?> get props => [ref];
}
