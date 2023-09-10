part of 'author_bloc.dart';

abstract class AuthorState {}

class Loading extends AuthorState {}

class Empty extends AuthorState {}

class CreateAuthorState extends AuthorState {
  final Author author;

  CreateAuthorState({required this.author});
}

class GetAllAuthorsState extends AuthorState {
  final List<GetAuthorsModel> authors;

  GetAllAuthorsState({required this.authors});
}

class Error extends AuthorState {
  final String message;

  Error({required this.message});
}

class Success extends AuthorState {
  final String message;

  Success({required this.message});
}

class DeleteAuthorsState extends AuthorState {}
