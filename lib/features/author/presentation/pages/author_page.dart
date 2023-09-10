import 'package:book_store/core/theme/colors.dart';
import 'package:book_store/features/author/data/models/author_get_all_model.dart';
import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/presentation/bloc/author_bloc.dart';
import 'package:book_store/features/author/presentation/widgets/author_fab.dart';
import 'package:book_store/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/add_author_dialog.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({Key? key}) : super(key: key);

  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  List<GetAuthorsModel> authors = [];
  bool hasRequestOneTimes = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthorBloc>(
      create: (_) => sl<AuthorBloc>(),
      child: BlocProvider<AuthorBloc>(
        create: (_) => sl<AuthorBloc>(),
        child: BlocBuilder<AuthorBloc, AuthorState>(
          builder: (ctx, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: appBgColor,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Authors',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ))),
                    const Icon(
                      Icons.search_rounded,
                      color: primary,
                    ),
                  ],
                ),
              ),
              body: BlocBuilder<AuthorBloc, AuthorState>(
                builder: (ctx, state) {
                  if (authors.isEmpty && !hasRequestOneTimes) {
                    ctx.read<AuthorBloc>().add(GetAllAuthorsEvent());
                    hasRequestOneTimes = true;
                    return Container();
                  } else if (state is Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetAllAuthorsState) {
                    authors = state.authors;
                    return buidListAuthors(state.authors, ctx);
                  }
                  return buidListAuthors(authors, ctx);
                },
              ),
              floatingActionButton: AuthorFAB(onFABClicked: () {
                ctx.read<AuthorBloc>().add(GetAllAuthorsEvent());
              }),
              resizeToAvoidBottomInset: true,
            );
          },
        ),
      ),
    );
  }

  Widget buildBody() {
    bool hasRequestOneTimes = false;
    return BlocProvider<AuthorBloc>(
        create: (_) => sl<AuthorBloc>(),
        child: BlocBuilder<AuthorBloc, AuthorState>(
          builder: (ctx, state) {
            if (authors.isEmpty && !hasRequestOneTimes) {
              ctx.read<AuthorBloc>().add(GetAllAuthorsEvent());
              hasRequestOneTimes = true;
              return Container();
            } else if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetAllAuthorsState) {
              authors = state.authors;
              return buidListAuthors(state.authors, ctx);
            }
            return buidListAuthors(authors, ctx);
          },
        ));
  }

  Future<bool> refreshAuthors(BuildContext context) {
    context.read<AuthorBloc>().add(GetAllAuthorsEvent());
    return Future(() => true);
  }

  Widget buidListAuthors(List<GetAuthorsModel> authors, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshAuthors(context),
      child: ListView.builder(
        itemCount: authors.length,
        itemBuilder: (context, index) {
          final person = authors[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              authors.removeAt(index);

              context
                  .read<AuthorBloc>()
                  .add(DeleteAuthorsEvent(authorId: person.id!));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${person.firstName} removed'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Card(
              elevation: 2.0,
              margin: const EdgeInsets.only(
                left: 8,
                right: 8,
                bottom: 4,
                top: 4,
              ),
              child: ListTile(
                title: Text('${person.firstName} ${person.lastName}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date of Birth: ${person.birthDate}'),
                    Text('Nationality: ${person.nationality}'),
                  ],
                ),
                trailing: InkWell(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext _context) {
                        return AddAuthorDialog(
                          author: person,
                          onClose: () {
                            context
                                .read<AuthorBloc>()
                                .add(GetAllAuthorsEvent());
                          },
                        );
                      },
                    );
                  },
                  child: Icon(Icons.edit), // Pencil icon
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
