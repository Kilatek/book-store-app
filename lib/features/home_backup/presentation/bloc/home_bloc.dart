import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/core/error/app_exception_wrapper.dart';
import 'package:book_store/core/util/stream/dispose_bag.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_action_stream_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_authors_usecase.dart';
import 'package:book_store/features/home_backup/domain/usecases/get_books_usecase.dart';
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
  }

  final GetBooksUsecase getBooksUsecase;
  final GetAuthorsUsecase getAuthorsUsecase;
  final GetActionStreamUsecase getActionStreamUsecase;

  Future<void> onHomeEventInital(
    HomeEventInital event,
    Emitter<HomeState> emit,
  ) async {
    add(const HomeEvent.updateAuthors());
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
            ),
          );
        },
        isHandleLoading: false,
      );
}
