import 'package:book_store/features/author/domain/entities/author.dart';
import 'package:book_store/features/author/presentation/widgets/add_author_dialog.dart';
import 'package:book_store/features/author/presentation/widgets/widgets.dart';
import 'package:book_store/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/author_bloc.dart';

class AuthorFAB extends StatelessWidget {
  final VoidCallback onFABClicked;

  const AuthorFAB({super.key, required this.onFABClicked});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Add author',
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext _context) {
              return AddAuthorDialog(
                onClose: () {
                  onFABClicked();
                },
              );
            },
          );
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
    );
  }
}
