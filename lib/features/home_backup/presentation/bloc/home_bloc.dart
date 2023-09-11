import 'dart:async';

import 'package:book_store/core/base/base_bloc.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
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
  ) : super(HomeState.initial()) {
    on<HomeEventInital>(onHomeEventInital);
  }
  final GetBooksUsecase getBooksUsecase;
  final GetAuthorsUsecase getAuthorsUsecase;

  Future<void> onHomeEventInital(
    HomeEventInital event,
    Emitter<HomeState> emit,
  ) async {
    await Future.wait([
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
      ),
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
      )
    ]);
  }
}
