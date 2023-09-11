import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/util/input_converter.dart';
import 'package:book_store/core/util/stream/dispose_bag.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/home_backup/domain/usecases/create_author_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/create_book_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/delete_author_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/delete_book_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_action_stream_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_author_detail_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_authors_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_book_detail_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_books_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/update_author_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/update_book_usecase.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_event.dart';
import 'home_state.dart';

@Injectable()
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(
    this.getBooksUsecase,
    this.getAuthorsUsecase,
    this.getActionStreamUsecase,
    this._inputConverter,
    this.createBookUsecase,
    this.createAuthorUsecase,
    this.getAuthorDetailUsecase,
    this.updateAuthorUsecase,
    this.deleteAuthorUsecase,
    this.getBookDetailUsecase,
    this.updateBookUsecase,
    this.deleteBookUsecase,
  ) : super(HomeState.initial()) {
    on<HomeEventInital>(
      onHomeEventInital,
      transformer: log(),
    );
    on<HomeEventAuthorsUpdated>(
      onHomeEventAuhorsUpdated,
      transformer: log(),
    );
    on<HomeEventBoooksUpdated>(
      onHomeEventBooksUpdated,
      transformer: log(),
    );

    on<AuthorFirstNameChanged>(
      onAuthorFirstNameChanged,
      transformer: log(),
    );

    on<AuthorLastNameChanged>(
      onAuthorLastNameChanged,
      transformer: log(),
    );

    on<AuthorBirthDateChanged>(
      onAuthorBirthDateChanged,
      transformer: log(),
    );
    on<AuthorNationalityChanged>(
      onAuthorNationalityChanged,
      transformer: log(),
    );

    on<BookNameChanged>(
      onBookNameChanged,
      transformer: log(),
    );
    on<BookDescriptionChanged>(
      onBookDescriptionChanged,
      transformer: log(),
    );
    on<BookPriceChanged>(
      onBookPriceChanged,
      transformer: log(),
    );

    on<BookPublicationDateChanged>(
      onBookPublicationDateChanged,
      transformer: log(),
    );

    on<BookAuthorChanged>(
      onBookAuthorChanged,
      transformer: log(),
    );

    on<BookEventInital>(
      onBookEventInital,
      transformer: log(),
    );
    on<AuthorEventInitial>(
      onAuthorEventInitial,
      transformer: log(),
    );
    on<HomeTabChanged>(
      onHomeTabChanged,
      transformer: log(),
    );
    on<HomeCreatePressed>(
      onHomeCreatePressed,
      transformer: log(),
    );

    on<CreateAuthorPressed>(
      onCreateAuthorPressed,
      transformer: log(),
    );
    on<UpdateAuthorPressed>(
      onUpdateAuthorPressed,
      transformer: log(),
    );

    on<DeleteAuthorPressed>(
      onDeleteAuthorPressed,
      transformer: log(),
    );

    on<CreateBookPressed>(
      onCreateBookPressed,
      transformer: log(),
    );
    on<UpdateBookPressed>(
      onUpdateBookPressed,
      transformer: log(),
    );

    on<DeleteBookPressed>(
      onDeleteBookPressed,
      transformer: log(),
    );
  }

  final GetBooksUsecase getBooksUsecase;
  final GetAuthorsUsecase getAuthorsUsecase;
  final GetActionStreamUsecase getActionStreamUsecase;
  final CreateBookUsecase createBookUsecase;
  final CreateAuthorUsecase createAuthorUsecase;
  final GetAuthorDetailUsecase getAuthorDetailUsecase;
  final UpdateAuthorUsecase updateAuthorUsecase;
  final DeleteAuthorUsecase deleteAuthorUsecase;
  final GetBookDetailUsecase getBookDetailUsecase;
  final UpdateBookUsecase updateBookUsecase;
  final DeleteBookUsecase deleteBookUsecase;
  final InputConverter _inputConverter;

  Future<void> onHomeEventInital(
    HomeEventInital event,
    Emitter<HomeState> emit,
  ) async {
    add(const HomeEvent.updateAuthors(false));
    add(const HomeEvent.updateBooks());
    getActionStreamUsecase.call(const Params(ref: 'books')).listen((event) {
      event.fold(
        (l) => addException(
          AppExceptionWrapper(appError: l),
        ),
        (r) => add(const HomeEvent.updateBooks()),
      );
    }).disposeBy(disposeBag);
  }

  Future<void> onBookEventInital(
    BookEventInital event,
    Emitter<HomeState> emit,
  ) async {
    if (event.pageType == PageType.update) {
      add(const HomeEvent.updateAuthors(false));
      await runBlocCatching<Book>(
        getBookDetailUsecase.call(GetBookDetailParams(id: event.id)),
        doOnSuccess: (book) {
          emit(
            state.copyWith(
              pageType: event.pageType,
              bookName: _inputConverter.defaultValidate(book.name),
              bookDescription:
                  _inputConverter.defaultValidate(book.description),
              bookPrice: _inputConverter.defaultValidate(book.price.toString()),
              bookPublicationDate:
                  _inputConverter.defaultValidate(book.publicationDate),
              bookAuthor: book.author,
            ),
          );
        },
      );
    } else {
      add(const HomeEvent.updateAuthors(true));
      emit(
        state.copyWith(
          pageType: event.pageType,
        ),
      );
    }
  }

  Future<void> onAuthorEventInitial(
    AuthorEventInitial event,
    Emitter<HomeState> emit,
  ) async {
    if (event.pageType == PageType.update) {
      await runBlocCatching<Author>(
        getAuthorDetailUsecase.call(GetAuthorDetailParams(id: event.id)),
        doOnSuccess: (author) {
          emit(
            state.copyWith(
              pageType: event.pageType,
              authorFirstName:
                  _inputConverter.defaultValidate(author.firstName),
              authorLastName: _inputConverter.defaultValidate(author.lastName),
              authorBirthDate:
                  _inputConverter.defaultValidate(author.birthDate),
              authorNationality:
                  _inputConverter.defaultValidate(author.nationality),
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          pageType: event.pageType,
        ),
      );
    }
  }

  Future<void> onHomeTabChanged(
    HomeTabChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        tabIndex: event.tabIndex,
      ),
    );
  }

  Future<void> onHomeCreatePressed(
    HomeCreatePressed event,
    Emitter<HomeState> emit,
  ) async {
    if (state.tabIndex == 0) {
      await navigator.push(BookRoute(id: null));
    } else {
      final isUpdate = await navigator.push(AuthorRoute(id: null));
      if (isUpdate == true) add(const HomeEvent.updateAuthors(false));
    }
  }

  Future<void> onHomeEventBooksUpdated(
    HomeEventBoooksUpdated event,
    Emitter<HomeState> emit,
  ) =>
      runBlocCatching<List<Book>>(
        getBooksUsecase.call(unit),
        doOnSuccess: (books) {
          emit(
            state.copyWith(
              books: books,
            ),
          );
        },
        isHandleLoading: false,
      );
  Future<void> onHomeEventAuhorsUpdated(
    HomeEventAuthorsUpdated event,
    Emitter<HomeState> emit,
  ) =>
      runBlocCatching<List<Author>>(
        getAuthorsUsecase.call(unit),
        doOnSuccess: (authors) {
          emit(
            state.copyWith(
              authors: authors,
              bookAuthor: event.isAuthorInitial
                  ? authors.firstOrNull
                  : state.bookAuthor,
            ),
          );
        },
        isHandleLoading: false,
      );

  Future<void> onAuthorFirstNameChanged(
    AuthorFirstNameChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        authorFirstName: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onAuthorLastNameChanged(
    AuthorLastNameChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        authorLastName: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onAuthorBirthDateChanged(
    AuthorBirthDateChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        authorBirthDate: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onAuthorNationalityChanged(
    AuthorNationalityChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        authorNationality: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onBookNameChanged(
    BookNameChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        bookName: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onBookDescriptionChanged(
    BookDescriptionChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        bookDescription: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onBookPublicationDateChanged(
    BookPublicationDateChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        bookPublicationDate: _inputConverter.defaultValidate(event.input),
      ),
    );
  }

  Future<void> onBookPriceChanged(
    BookPriceChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        bookPrice: _inputConverter.price(event.input),
      ),
    );
  }

  Future<void> onBookAuthorChanged(
    BookAuthorChanged event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        bookAuthor: event.author,
      ),
    );
  }

  Future<void> onCreateAuthorPressed(
    CreateAuthorPressed event,
    Emitter<HomeState> emit,
  ) async {
    final isAuthorFirstName = state.authorFirstName.isRight();
    final isAuthorLastName = state.authorLastName.isRight();
    final isAuthorBirthDate = state.authorBirthDate.isRight();
    final isAuthorNationality = state.authorNationality.isRight();

    final isVail = [
      isAuthorFirstName,
      isAuthorLastName,
      isAuthorBirthDate,
      isAuthorNationality
    ].every((element) => element == true);

    if (isVail) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<Unit>(
        createAuthorUsecase.call(
          CreateAuthorParams(
            firstName: state.authorFirstName.getOrElse(() => ''),
            lastName: state.authorLastName.getOrElse(() => ''),
            birthDate: state.authorBirthDate.getOrElse(() => ''),
            nationality: state.authorNationality.getOrElse(() => ''),
          ),
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
          navigator.showSuccessSnackBar(message: 'Create Author Success');
          Future.delayed(const Duration(seconds: 2), () {
            navigator.pop(result: true);
          });
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }

  Future<void> onUpdateAuthorPressed(
    UpdateAuthorPressed event,
    Emitter<HomeState> emit,
  ) async {
    final isAuthorFirstName = state.authorFirstName.isRight();
    final isAuthorLastName = state.authorLastName.isRight();
    final isAuthorBirthDate = state.authorBirthDate.isRight();
    final isAuthorNationality = state.authorNationality.isRight();

    final isVail = [
      isAuthorFirstName,
      isAuthorLastName,
      isAuthorBirthDate,
      isAuthorNationality
    ].every((element) => element == true);

    if (isVail) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<Unit>(
        updateAuthorUsecase.call(
          UpdateAuthorParams(
            id: event.id,
            firstName: state.authorFirstName.getOrElse(() => ''),
            lastName: state.authorLastName.getOrElse(() => ''),
            birthDate: state.authorBirthDate.getOrElse(() => ''),
            nationality: state.authorNationality.getOrElse(() => ''),
          ),
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
          navigator.showSuccessSnackBar(message: 'Update Author Success');
          Future.delayed(const Duration(seconds: 2), () {
            navigator.pop(result: true);
          });
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }

  Future<void> onDeleteAuthorPressed(
    DeleteAuthorPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
      ),
    );
    await runBlocCatching<Unit>(
      deleteAuthorUsecase.call(
        DeleteAuthorParams(
          id: event.id,
          firstName: state.authorFirstName.getOrElse(() => ''),
          lastName: state.authorLastName.getOrElse(() => ''),
          birthDate: state.authorBirthDate.getOrElse(() => ''),
          nationality: state.authorNationality.getOrElse(() => ''),
        ),
      ),
      doOnSuccess: (auth) {
        emit(
          state.copyWith(
            isSubmitting: false,
          ),
        );
        navigator.showSuccessSnackBar(message: 'Delete Author Success');
        navigator.pop(result: true);
      },
      doOnError: (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
          ),
        );
      },
      isHandleLoading: false,
    );
  }

  Future<void> onCreateBookPressed(
    CreateBookPressed event,
    Emitter<HomeState> emit,
  ) async {
    final isVail = [
      state.bookName.isRight(),
      state.bookDescription.isRight(),
      state.bookPublicationDate.isRight(),
      state.bookPrice.isRight(),
      state.bookAuthor != null,
    ].every((element) => element == true);

    if (isVail) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<Unit>(
        createBookUsecase.call(
          CreateBookParams(
            name: state.bookName.getOrElse(() => ''),
            description: state.bookDescription.getOrElse(() => ''),
            publicationDate: state.bookPublicationDate.getOrElse(() => ''),
            price: double.tryParse(state.bookPrice.getOrElse(() => "0")) ?? 0.0,
            authorId: state.bookAuthor!.id,
          ),
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
          navigator.showSuccessSnackBar(message: 'Create Book Success');
          Future.delayed(const Duration(seconds: 2), () {
            navigator.pop(result: true);
          });
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }

  Future<void> onUpdateBookPressed(
    UpdateBookPressed event,
    Emitter<HomeState> emit,
  ) async {
    final isVail = [
      state.bookName.isRight(),
      state.bookDescription.isRight(),
      state.bookPublicationDate.isRight(),
      state.bookPrice.isRight(),
      state.bookAuthor != null,
    ].every((element) => element == true);
    if (isVail) {
      emit(
        state.copyWith(
          isSubmitting: true,
        ),
      );
      await runBlocCatching<Unit>(
        updateBookUsecase.call(
          UpdateBookParams(
            id: event.id,
            name: state.bookName.getOrElse(() => ''),
            description: state.bookDescription.getOrElse(() => ''),
            publicationDate: state.bookPublicationDate.getOrElse(() => ''),
            price: double.tryParse(state.bookPrice.getOrElse(() => "0")) ?? 0.0,
            authorId: state.bookAuthor!.id,
          ),
        ),
        doOnSuccess: (auth) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
          navigator.showSuccessSnackBar(message: 'Update Book Success');
          Future.delayed(const Duration(seconds: 2), () {
            navigator.pop(result: true);
          });
        },
        doOnError: (_) {
          emit(
            state.copyWith(
              isSubmitting: false,
            ),
          );
        },
        isHandleLoading: false,
      );
    }
  }

  Future<void> onDeleteBookPressed(
    DeleteBookPressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isSubmitting: true,
      ),
    );
    await runBlocCatching<Unit>(
      deleteBookUsecase.call(
        DeleteBookParams(
          id: event.id,
          name: state.bookName.getOrElse(() => ''),
          description: state.bookDescription.getOrElse(() => ''),
          publicationDate: state.bookPublicationDate.getOrElse(() => ''),
          price: double.tryParse(state.bookPrice.getOrElse(() => "0")) ?? 0.0,
          authorId: state.bookAuthor!.id,
        ),
      ),
      doOnSuccess: (auth) {
        emit(
          state.copyWith(
            isSubmitting: false,
          ),
        );
        navigator.showSuccessSnackBar(message: 'Delete Book Success');
        navigator.pop(result: true);
      },
      doOnError: (_) {
        emit(
          state.copyWith(
            isSubmitting: false,
          ),
        );
      },
      isHandleLoading: false,
    );
  }
}
