import 'package:book_store/core/base/base_state.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseBlocState with _$HomeState {
  const factory HomeState({
    required List<Book> books,
    required List<Author> authors,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
        books: [],
        authors: [],
      );
}
