import 'package:book_store/core/error/app_error.dart';
import 'package:dartz/dartz.dart';

abstract class UseCaseStream<Type, Params> {
  Stream<Either<AppError, Type>> call(Params params);
}
