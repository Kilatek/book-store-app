import 'package:book_store/core/base/base_event.dart';
import 'package:book_store/features/home_backup/domain/entities/author.dart';
import 'package:book_store/navigation/app_routes.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.freezed.dart';

@freezed
class HomeEvent extends BaseBlocEvent with _$HomeEvent {
  const factory HomeEvent.initial() = HomeEventInital;
  const factory HomeEvent.updateBooks() = HomeEventBoooksUpdated;
  const factory HomeEvent.updateAuthors() = HomeEventAuthorsUpdated;
  const factory HomeEvent.authorFirstNameChanged(String input) =
      AuthorFirstNameChanged;
  const factory HomeEvent.authorLastNameChanged(String input) =
      AuthorLastNameChanged;
  const factory HomeEvent.authorBirthDateChanged(String input) =
      AuthorBirthDateChanged;
  const factory HomeEvent.authorNationalityChanged(String input) =
      AuthorNationalityChanged;
  const factory HomeEvent.bookNameChanged(String input) = BookNameChanged;
  const factory HomeEvent.bookDescriptionChanged(String input) =
      BookDescriptionChanged;
  const factory HomeEvent.bookPublicationDateChanged(String input) =
      BookPublicationDateChanged;
  const factory HomeEvent.bookPriceChanged(String input) = BookPriceChanged;
  const factory HomeEvent.bookAuthorChanged(Author author) = BookAuthorChanged;

  const factory HomeEvent.createAuthorPressed() = CreateAuthorPressed;
  const factory HomeEvent.createBookPressed() = CreateBookPressed;

  const factory HomeEvent.updateAuthorPressed(String id) = UpdateAuthorPressed;
  const factory HomeEvent.deleteAuthorPressed(String id) = DeleteAuthorPressed;
  const factory HomeEvent.updateBookPressed() = UpdateBookPressed;
  const factory HomeEvent.bookInitial(PageType pageType) = BookEventInital;
  const factory HomeEvent.authorInitial(PageType pageType, String id) =
      AuthorEventInitial;
  const factory HomeEvent.tabChanged(int tabIndex) = HomeTabChanged;
  const factory HomeEvent.createPressed() = HomeCreatePressed;
}
