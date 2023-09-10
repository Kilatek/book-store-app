import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/core/error/error_mapper.dart';
import 'package:book_store/core/error/exceptions.dart';
import 'package:dartx/dartx.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class InputConverter {
  Result<String> email(String input) {
    // const emailRegex =
    //     r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    try {
      if (input.isBlank) throw ValidateEmptyException();
      // if (!RegExp(emailRegex).hasMatch(input)) {
      //   throw ValidateWronEmailException();
      // }
      return Right(input);
    } catch (e) {
      return Left(ErrorMapperFactory.map(e));
    }
  }

  Result<String> password(String input) {
    try {
      if (input.isBlank) throw ValidateEmptyException();
      if (input.length < 6) throw ValidateWrongPasswordException();
      return Right(input);
    } catch (e) {
      return Left(ErrorMapperFactory.map(e));
    }
  }
}
