import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/auth/domain/respositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class ClearCurrentUserUsecase implements UseCase<Unit, Unit> {
  final AuthRepository repository;

  ClearCurrentUserUsecase(this.repository);

  @override
  Future<Either<AppError, Unit>> call(Unit params) async {
    return await repository.clearCurrentUserData();
  }
}
