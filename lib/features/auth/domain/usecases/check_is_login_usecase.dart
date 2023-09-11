import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/auth/domain/respositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class CheckIsLoginUsecase implements UseCase<bool, Unit> {
  final AuthRepository repository;

  CheckIsLoginUsecase(this.repository);

  @override
  Future<Either<AppError, bool>> call(Unit params) async {
    return await repository.isLoginUser();
  }
}
