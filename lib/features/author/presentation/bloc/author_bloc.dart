import 'package:bloc/bloc.dart';
import 'package:book_store/core/usecases/usecase.dart';
import 'package:book_store/features/author/data/models/author_get_all_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/domain/usecases/create_author.dart';
import 'package:book_store/features/author/domain/usecases/delete_author.dart';
import 'package:book_store/features/author/domain/usecases/find_author.dart';
import 'package:book_store/features/author/domain/usecases/get_authors.dart';
import 'package:book_store/features/author/domain/usecases/update_author.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final CreateAuthor createAuthor;
  final DeleteAuthor deleteAuthor;
  final FindAuthor findAuthor;
  final GetAuthors getAuthors;
  final UpdateAuthor updateAuthor;

  AuthorState get initialState => Empty();

  AuthorBloc({
    required this.createAuthor,
    required this.deleteAuthor,
    required this.findAuthor,
    required this.getAuthors,
    required this.updateAuthor,
  }) : super(Empty()) {
    on<CreateAuthorEvent>((event, emit) async {
      emit(Loading());
      final failureOrCreated = await createAuthor(event.author);
      failureOrCreated!.fold((failure) {
        emit(Error(message: "Create failed"));
      }, (data) {
        emit(Success(message: "Created"));
      });
    });
    on<GetAllAuthorsEvent>((event, emit) async {
      emit(Loading());
      final failureOrGet = await getAuthors(NoParams());
      failureOrGet!.fold((failure) {
        emit(Error(message: "Get failed"));
      }, (data) {
        emit(GetAllAuthorsState(authors: data));
      });
    });
    on<DeleteAuthorsEvent>((event, emit) async {
      final failureOrDelete = await deleteAuthor(event.authorId!);
      failureOrDelete!.fold((failure) {
        emit(Error(message: "Get failed"));
      }, (data) {
        emit(DeleteAuthorsState());
      });
    });
    on<UpdateAuthorEvent>((event, emit) async {
      emit(Loading());
      final failureOrUpdate = await updateAuthor(event.author);
      failureOrUpdate!.fold((failure) {
        emit(Error(message: "Get failed"));
      }, (data) {
        emit(Success(message: "Updated"));
      });
    });
  }
}
