import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/auth/domain/entities/user.dart';
import 'package:book_store/features/auth/domain/respositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';

@Injectable()
class LoginUsecase implements UseCase<User, Params> {
  final AuthRepository repository;

  LoginUsecase(this.repository);

  @override
  Future<Either<AppError, User>> call(Params params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  const Params({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
