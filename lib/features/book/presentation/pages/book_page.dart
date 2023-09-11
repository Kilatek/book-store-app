import 'package:book_store/core/theme/colors.dart';
import 'package:book_store/features/home_backup/domain/entities/book.dart';
import 'package:book_store/features/book/presentation/widgets/book_item.dart';
import 'package:flutter/material.dart';

class BookPage extends StatefulWidget {
  List<Book> books = [];
  BookPage(this.books);
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            widget.books.length,
            (index) => BookItem(
              book: widget.books[index],
            ),
          ),
        ),
      ),
    );
  }
}
