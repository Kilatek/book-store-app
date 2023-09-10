part of 'author_bloc.dart';

abstract class AuthorEvent {}

class SelectDateEvent extends AuthorEvent {
  final DateTime selectedDate;

  SelectDateEvent(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class CreateAuthorEvent extends AuthorEvent {
  final Author author;

  CreateAuthorEvent({required this.author});
}

class UpdateAuthorEvent extends AuthorEvent {
  final GetAuthorsModel author;

  UpdateAuthorEvent({required this.author});
}

class GetAllAuthorsEvent extends AuthorEvent {}

class DeleteAuthorsEvent extends AuthorEvent {
  final String authorId;

  DeleteAuthorsEvent({required this.authorId});
}
