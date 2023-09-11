import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/core/error/app_error.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseBlocState with _$HomeState {
  const factory HomeState({
    required List<Book> books,
    required bool isSubmitting,
    required List<Author> authors,
    required Result<String> authorFirstName,
    required Result<String> authorLastName,
    required Result<String> authorBirthDate,
    required Result<String> authorNationality,
    required Result<String> bookName,
    required Result<String> bookDescription,
    required Result<String> bookPublicationDate,
    required Result<String> bookPrice,
    required int tabIndex,
    PageType? pageType,
    Author? bookAuthor,
  }) = _HomeState;

  factory HomeState.initial() => HomeState(
        tabIndex: 0,
        isSubmitting: false,
        pageType: null,
        books: [],
        authors: [],
        authorFirstName: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        authorLastName: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        authorBirthDate: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        authorNationality: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        bookName: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        bookDescription: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        bookPublicationDate: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
        bookPrice: Left<AppError, String>(
          AppError(
            appExceptionType: AppExceptionType.validateEmpty,
            message: 'Value Not Empty',
            error: Object(),
          ),
        ),
      );
}
